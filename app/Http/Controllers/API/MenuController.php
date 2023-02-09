<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 

use App\Models\User;
use App\Models\CompanyList; 

use Illuminate\Support\Facades\Auth; 

class MenuController extends Controller
{
    public function index()
    {
        $user = User::find(Auth::id());
        
        if (!$user) {
            return response()->json(['success' => 0, $menus => []], 200);
        }

        $menus = self::getMenus($user);

        return response()->json(['success' => 1, 'menus' => $menus], 200);
    }

    public static function getMenus($user) {
        if ($user->type === 'Admin') { 
            return self::administrator($user);
        } else if ($user->type === 'Employer') { 
            return self::employer($user);
        } else if ($user->type === 'Candidate') { 
            return self::candidate($user);
        }
    }

    public static function administrator($user) {
        $menus[] = [
            'text' => 'Dashboard',
            'route' => '/dashboard',
            'icon' => 'bx bxs-dashboard'
        ];

        $menus[] = [
            'text' => 'Message Center',
            'route' => '/message-center',
            'icon' => 'bx bx-mail-send'
        ];
        /*
        $menus[] = [
            'text' => 'Messages',
            'route' => '/inbox',
            'icon' => 'bx bx-envelope'
        ];
        */

        $menus[] = [
            'text' => 'Jobs',
            'route' => '#has-submenu',
            'icon' => 'bx bx-data',
            'submenus' => [
                [ 'text' => 'Posts', 'route' => '/jobs/posts'],
                [ 'text' => 'Categories', 'route' => '/jobs/categories'],
                [ 'text' => 'Subcategories', 'route' => '/jobs/subcategories'],
                [ 'text' => 'Core Competencies', 'route' => '/jobs/core-competencies'],
            ]
        ];

        /*
        $menus[] = [
            'text' => 'Personnel Requests',
            'route' => '/personnels/requests',
            'icon' => 'bx bx-briefcase-alt'
        ];
        */

        $menus[] = [
            'text' => 'Personnel',
            'route' => '#has-submenu',
            'icon' => 'mdi mdi-account-group',
            'submenus' => [
                [ 'text' => 'Employed', 'route' => '/personnels'],
                [ 'text' => 'Requests', 'route' => '/personnels/requests'],
            ]
        ];


        $menus[] = [
            'text' => 'Companies',
            'route' => '/companies',
            'icon' => 'bx bx-buildings'
        ];


        $menus[] = [
            'text' => 'Users',
            'route' => '#has-submenu',
            'icon' => 'mdi mdi-account-tie',
            'submenus' => [
                [ 'text' => 'Administrators', 'route' => '/administrators'],
                [ 'text' => 'Employers', 'route' => '/employers'],
                [ 'text' => 'Candidates', 'route' => '/candidates'],
            ]
        ];

       

        

        return $menus;
    }

    public static function employer($user)
    {
        $menus[] = [
            'text' => 'Dashboard',
            'route' => '/dashboard',
            'icon' => 'bx bxs-dashboard'
        ];

        $menus[] = [
            'text' => 'Manage Personnel',
            'route' => '/personnels',
            'icon' => 'fas fa-users'
        ];

        $menus[] = [
            'text' => 'Request Personnel',
            'route' => '/personnels/requests',
            'icon' => 'mdi mdi-badge-account-alert'
        ];

        /*
        $menus[] = [
            'text' => 'Messages',
            'route' => '/inbox',
            'icon' => 'bx bx-envelope'
        ];

        
        $menus[] = [
            'text' => 'Jobs',
            'route' => '/jobs/posts',
            'icon' => 'bx bx-briefcase-alt'
        ];
        

        $menus[] = [
            'text' => 'Personnel',
            'route' => '#has-submenu',
            'icon' => 'mdi mdi-account-group',
            'submenus' => [
                [ 'text' => 'Employees', 'route' => '/personnels'],
                [ 'text' => 'My Requests', 'route' => '/personnels/requests'],
            ]
        ];
        */

        
        if($user->is_company_admin) {
            $menus[] = [
                'text' => 'Users',
                'route' => '/employers',
                'icon' => 'fas fa-user-tie'
            ];
        }

        $menus[] = [
            'text' => 'Recommendations',
            'route' => '/jobs/recommendations',
            'icon' => 'bx bx-star'
        ];

        return $menus;
    }

    public static function candidate($user) {
        $menus[] = [
            'text' => 'Dashboard',
            'route' => '/dashboard',
            'icon' => 'bx bxs-dashboard'
        ];
        /*
        $menus[] = [
            'text' => 'Messages',
            'route' => '/inbox',
            'icon' => 'bx bx-envelope'
        ];
        */

        // $menus[] = [
        //     'text' => 'My Resume',
        //     'route' => '/resume/'.$user->username,
        //     'icon' => 'bx bx-id-card'
        // ];


        $menus[] = [
            'text' => 'Jobs',
            'route' => '/jobs/posts',
            'icon' => 'bx bx-briefcase-alt'
        ];

        $menus[] = [
            'text' => 'Recommendations',
            'route' => '/jobs/recommendations',
            'icon' => 'bx bx-star'
        ];



        return $menus;
    }

}