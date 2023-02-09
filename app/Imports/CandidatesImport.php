<?php

namespace App\Imports;

use Illuminate\Support\Collection;
use App\Models\User;
use App\Models\UserSkill;
use App\Models\JobSubcategory;
use App\Models\JobType;
use App\Models\JobSubcategoryItem;
use Throwable;

use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\WithValidation;
use Maatwebsite\Excel\Concerns\Importable;
use Maatwebsite\Excel\Imports\HeadingRowFormatter;
use Maatwebsite\Excel\Concerns\ToCollection;

HeadingRowFormatter::default('none');

class CandidatesImport implements
    WithHeadingRow,
    ToCollection
{
    use Importable;
    public $heading_row = 2;
    public $errors = [
        'null_values' => [],
        'existing_emails' => [],
    ];
    public $row_counter;
    public $imported_counter;
    public $subcategories = [
        'names' => [
            'Class 1 / 3 – Drivers / Operators',
            'Trades',
            'Heavy equipment operators',
            'General Oilfield',
            'General Construction'
        ],
        'ids' => []
    ];
    public $skills = [];

    public function collection(Collection $rows)
    {
        # get ID's of JobSubcategory
        foreach ($this->subcategories['names'] as $subcategory) {
            $job_subcategory = JobSubcategory::where('name','=',$subcategory)->first();
            array_push($this->subcategories['ids'], $job_subcategory->id);
        }
        
        foreach ($rows as $row)
        {
            if ($this->validate($row)) {
                continue;
            }

            $this->imported_counter++;
            
            $user = User::create([
                'last_name' => $row['Last Name'],
                'first_name' => $row['First Name'],
                'email' => $row['Email Address'],
                'phone' => $row['Phone Number'],
                'type' => 'Candidate',
                'password' => \Hash::make($row['Password'])
            ]);


            # convert excel 'row' of subcategories to array
            $skill_category = [];
            $skill_categories = [];
            $subcategory_counter = 0;

            foreach ($this->subcategories['names'] as $subcategory) {
                $arrayOfNames = $this->stringToArray($row[$subcategory]);
                $arrayOfIDs   = $this->convertIntoArrayOfIDs($arrayOfNames);

                $skill_category = [
                    'subcategory_id' => $this->subcategories['ids'][$subcategory_counter],
                    'subcategory_skills' => $arrayOfIDs
                ];

                array_push($skill_categories, $skill_category); 
                $subcategory_counter++;
            }

            # get job_subcategory_items ids base on 'job_types ids' AND 'job_subcategory_id'
            $job_subcategory_items = [];

            foreach ($skill_categories as $skill_category) {
                foreach ($skill_category['subcategory_skills'] as $subcategory_skill) {
                    $exists = JobSubcategoryItem::where('job_type_id', $subcategory_skill)
                    ->where('job_subcategory_id', $skill_category['subcategory_id'])
                    ->first();

                    if ($exists) {
                        array_push($job_subcategory_items, $exists->id);
                    }
                }
            }
            
            # save job_subcategory_items IDs and user ID to 'user_skills'
            foreach ($job_subcategory_items as $job_subcategory_item) {
                UserSkill::create([
                    'user_id' => $user->id,
                    'job_subcategory_item_id' => $job_subcategory_item
                ]);
            }
        }
    }

    public function headingRow(): int
    {
        return $this->heading_row;
    }

    public function validate($row)
    {
        $this->row_counter++;

        # skip empty fields
        if ($row['Last Name'] == '' && $row['First Name'] == '' && $row['Email Address'] == '' && $row['Password'] == '') {
            return true;
        }

        # if a field has null/missing value
        if ($row['Last Name'] == '' || $row['First Name'] == '' || $row['Email Address'] == '' || $row['Password'] == '') {
            array_push($this->errors['null_values'], $this->row_counter + $this->heading_row);
            return true;
        }

        # if email already exist
        $exists = User::where('email','=',$row['Email Address'])->withTrashed()->first();
        if ($exists) {
            $error = [
                'row' => $this->row_counter,
                'email' => $row['Email Address']
            ];
            array_push($this->errors['existing_emails'], $error);
            return true;
        }

        return false;
    }

    public function stringToArray($string) {
        $string = trim($string);
        $split = explode(',', $string);
        
        $skills = [];
        
        foreach ($split as $skill) {
            array_push($skills, trim($skill));
        }
        return $skills;
    }

    public function convertIntoArrayOfIDs ($skillset)
    {
        $arrayOfIDs = [];

        foreach ($skillset as $skill) {
            $exists = JobType::where('name','=',$skill)->first();
            if ($exists) {
                array_push($arrayOfIDs, $exists->id);
            }
        }

        return $arrayOfIDs;
    }
}
