<template>
    <div v-if="properties && properties.type" style="background: #f5f5f5">
        <div class="personnel-form-wrap p-4">
            <div id="progrss-wizard" class="twitter-bs-wizard">
                <div style="padding: 10px; border: 1px solid #ddd; border-radius: 4px;">
                    <div class="progress"><div :id=" 'progress-' + properties.type" class="progress-bar progress-bar-animated bg-success progress-bar-striped" role="progressbar" aria-valuenow="16.6666667" aria-valuemin="0" aria-valuemax="100" style="width: 16.6666667%;"></div></div>
                    <div class="progress-bar bg-success progress-bar-striped progress-bar-animated"></div>
                </div>
                <div class="tab-content twitter-bs-wizard-tab-content">

                    <div class="tab-pane" v-bind:class="{'active' : page == 1}">

                        <div class="alert alert-danger alert-icon" v-show="personnel_data.error">
                            <i class="bx bx-error"></i> <strong>Oops</strong>! {{ personnel_data.error }}
                        </div>

                        <div class="row">
                            <div class="col-lg-12">
                                <div style="border: 1px solid rgba(0,0,0,.1); border-radius: 4px; padding: 20px;">
                                    <div class="row">
                                        <div class="col-lg-5">
                                        
                                            <div class="form-group"><label :for="'basicpill-shiftdu-' + properties.type" class="">Shift Duration (Hours per day/per shift)</label><input v-model="personnel_data.shift_duration" :id="'basicpill-shiftdu-' + properties.type" type="number" step=".5" class="form-control form-control" /></div>
                                            
                                        </div>
                                        <div class="col-lg-7">
                                            <div class="form-group">
                                                <label :for="'percentage_of_people_on_day_shift-' + properties.type">Percentage of people on day shift: {{ personnel_data.percentage_of_people_on_day_shift }}%</label><br>
                                                <div style="background: #ddd; border-radius: 4px; padding: 10px 15px 6px;">
                                                    <input v-model="personnel_data.percentage_of_people_on_day_shift" type="range" min="0" max="100" step="10" :id="'percentage_of_people_on_day_shift-' + properties.type" class="w-100">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="form-group">
                                                <label :for="'basicpill-scope-' + properties.type" class="">Project Description and  Scope of Work</label>
                                                <textarea v-model="personnel_data.scope_of_work" :id="'basicpill-scope-' + properties.type" class="form-control" rows="2" style="min-height: 110px;"></textarea>
                                            </div>
                                            <br>

                                            <div id="accordion">
                                                <h4 class="mb-3"><span class="text-capitalize">{{ properties.type }}</span> Details</h4>
                                                <div class="card" v-for="(personnel_detail, index_details) in personnel_data.personnel_details" :key="'personnel_details-' + index_details">
                                                    <div class="card-header justify-content-between d-flex">
                                                        <a class="card-link text-black text-md" data-toggle="collapse" v-bind:href="'#collapse'+index_details">
                                                            <span class="text-capitalize">{{ properties.type }}</span> #{{index_details+1}}
                                                        </a>
                                                        <div class="text-lg">
                                                            <a @click="deletePersonnelDetails(index_details)" class="text-danger"><i v-if="index_details !== 0" class="bx bx-trash"></i></a>
                                                            <a href="#" class="text-black" data-toggle="collapse" v-bind:href="'#collapse'+index_details"><i class="bx bx-chevron-down"></i></a>
                                                        </div>
                                                    </div>
                                                    <div v-bind:id="'collapse'+index_details" class="collapse show" data-parent="#accordion">
                                                        <div class="card-body">
                                                            <div class="form-group">
                                                                <label>Job title</label>
                                                                <input
                                                                    type="text"
                                                                    placeholder="Job Title"
                                                                    v-model="personnel_detail.job_title"
                                                                    class="form-control"
                                                                    :id="'job-title-' + index_details"
                                                                />
                                                                <input type="hidden" :value="properties.type" class="form-control" name="job_personnel" />

                                                            </div>
                                                            <div class="form-group">
                                                                <label>No. of <span class="text-capitalize">{{ properties.type }}</span></label>
                                                                <input
                                                                    type="number"
                                                                    :placeholder="'No. of ' + toTitleCase(properties.type)"
                                                                    v-model="personnel_detail.quantity"
                                                                    class="form-control"
                                                                    :id="'job-no-of-operators-' + index_details"
                                                                />
                                                            </div>
                                                            <div class="form-group">
                                                                <label>Job Description</label>
                                                                <textarea
                                                                    placeholder="Write Description"
                                                                    class="form-control"
                                                                    :id="'job-description-' + index_details"
                                                                    v-model="personnel_detail.job_description"
                                                                ></textarea>
                                                            </div>
                                                        </div>
                                                        
                                                        
                                                        <div class="pr-core-comp-wrap">
                                                            <div class="pr-core-comp-header">
                                                                <h4>Core Competencies</h4>
                                                            </div>
                                                            <div class="pr-core-comp-body">
                                                                <template v-for="(subcategory, index) in subcategories" >
                                                                    <div :key="'cc-single-' + index" class="pr-core-comp-single" :class="{'active': index == 0}">
                                                                        <div :key="'cc-header-' + index" class="pr-core-comp-single-header">
                                                                            <span>{{ subcategory.name }}</span>

                                                                            <div class="pr-core-comp-icon">
                                                                                <i class="mdi mdi-plus-circle"></i>
                                                                                <i class="mdi mdi-minus-circle"></i>
                                                                            </div>
                                                                        </div>
                                                                        <div :key="'cc-content-' + index" class="pr-core-comp-single-body">
                                                                            <div class="row">
                                                                                <div v-for="(type, index_types) in subcategory.job_types" :key="'ktype-' + index + '-' + index_types"  class="col-12 col-sm-6 col-md-4 col-lg-3">
                                                                                    <div class="form-check mb-3">
                                                                                        <input @click="toggleSkill(type.id, index_details)" class="form-check-input" type="checkbox" value="" :id="'type-' + index + '-' + index_types" :checked="isSkillSelected(type.id, index_details)">
                                                                                        <label class="form-check-label" :for="'type-' + index + '-' + index_types">
                                                                                            {{ type.job_type.name }}
                                                                                        </label>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </template>
                                                                
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <button @click="addPersonnelDetails()" class="btn btn-info">Add new</button>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane" v-bind:class="{'active' : page == 2}">

                            <div class="alert alert-danger alert-icon" v-show="personnel_data.error">
                                <i class="bx bx-error"></i> <strong>Oops</strong>! {{ personnel_data.error }}
                            </div>

                            <div class="row tickets-orientations-row">
                                <br>
                                <div class="col-lg-4">
                                    <h4 class="card-title mb-4" style="font-size: 13px;">Tickets Required</h4>

                                    <div class="form-group">
                                        <div class="d-flex align-items-center">
                                            <input @click="checkboxToggle('first_aid', 'show_firstAidInput')" v-bind:checked="personnel_data.required_ticket.first_aid"  :id="'show_firstAidCheckbox-' + properties.type" type="checkbox" class="mr-2" />
                                            <label :for="'show_firstAidCheckbox-' + properties.type" class="mb-0 mr-2">First Aid</label>
                                            <input
                                                v-show="show_firstAidInput || personnel_data.required_ticket.first_aid"
                                                v-model="personnel_data.required_ticket.first_aid"
                                                type="text"
                                                class="form-control form-control"
                                                placeholder="Details - if any"
                                                :id="'show_firstAidInput-' + properties.type"
                                            />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="d-flex align-items-center">
                                            <input @click="checkboxToggle('H2S_alive', 'show_H2SInput')" v-bind:checked="personnel_data.required_ticket.H2S_alive" :id="'show_H2SCheckbox-' + properties.type" type="checkbox" class="mr-2" />
                                            <label :for="'show_H2SCheckbox-' + properties.type" class="mb-0 mr-2">H2S Alive</label>
                                            <input
                                                v-show="show_H2SInput || personnel_data.required_ticket.H2S_alive"
                                                v-model="personnel_data.required_ticket.H2S_alive"
                                                type="text"
                                                :id="'show_H2SInput-' + properties.type"
                                                class="form-control form-control"
                                                placeholder="Details - if any"
                                            />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="d-flex align-items-center">
                                            <input @click="checkboxToggle('CSTS', 'show_CSTSInput')" v-bind:checked="personnel_data.required_ticket.CSTS" :id="'show_CSTSCheckbox-' + properties.type" type="checkbox" class="mr-2" />
                                            <label :for="'show_CSTSCheckbox-' + properties.type" class="mb-0 mr-2">CSTS</label>
                                            <input
                                                v-show="show_CSTSInput || personnel_data.required_ticket.CSTS"
                                                v-model="personnel_data.required_ticket.CSTS"
                                                type="text"
                                                :id="'show_CSTSInput-' + properties.type"
                                                class="form-control form-control"
                                                placeholder="Details - if any"
                                            />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="d-flex align-items-center">
                                            <input @click="checkboxToggle('confined_space', 'show_CofinedSpaceInput')" v-bind:checked="personnel_data.required_ticket.confined_space" :id="'show_CofinedSpaceCheckbox-' + properties.type" type="checkbox" class="mr-2"/>
                                            <label :for="'show_CofinedSpaceCheckbox-' + properties.type" class="mb-0 mr-2">Confined Space</label>
                                            <input
                                                v-show="show_CofinedSpaceInput || personnel_data.required_ticket.confined_space"
                                                v-model="personnel_data.required_ticket.confined_space"
                                                type="text"
                                                :id="'show_CofinedSpaceInput-' + properties.type"
                                                class="form-control form-control"
                                                placeholder="Details - if any"
                                            />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="d-flex align-items-center">
                                            <input @click="checkboxToggle('ground_disturbance', 'show_groundDisInput')" v-bind:checked="personnel_data.required_ticket.ground_disturbance" :id="'show_groundDisCheckbox-' + properties.type" type="checkbox" class="mr-2" />
                                            <label :for="'show_groundDisCheckbox-' + properties.type" class="mb-0 mr-2">Ground Disturbance</label>
                                            <input
                                                v-show="show_groundDisInput || personnel_data.required_ticket.ground_disturbance"
                                                v-model="personnel_data.required_ticket.ground_disturbance"
                                                type="text"
                                                :id="'show_groundDisInput-' + properties.type"
                                                class="form-control form-control"
                                                placeholder="Details - if any"
                                            />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="d-flex align-items-center">
                                            <input @click="checkboxToggle('fall_arrest', 'show_fallArresetInput')" v-bind:checked="personnel_data.required_ticket.fall_arrest" :id="'show_fallArresetCheckbox-' + properties.type" type="checkbox" class="mr-2" />
                                            <label :for="'show_fallArresetCheckbox-' + properties.type" class="mb-0 mr-2">Fall Arrest</label>
                                            <input
                                                v-show="show_fallArresetInput || personnel_data.required_ticket.fall_arrest"
                                                v-model="personnel_data.required_ticket.fall_arrest"
                                                type="text"
                                                :id="'show_fallArresetInput-' + properties.type"
                                                class="form-control form-control"
                                                placeholder="Details - if any"
                                            />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="d-flex align-items-center">
                                            <input @click="checkboxToggle('CSO', 'show_CSOInput')" v-bind:checked="personnel_data.required_ticket.CSO" :id="'show_CSOCheckbox-' + properties.type" type="checkbox" class="mr-2" />
                                            <label :for="'show_CSOCheckbox-' + properties.type" class="mb-0 mr-2">CSO (BSO/eGSO/PST)</label>
                                            <input
                                                v-show="show_CSOInput || personnel_data.required_ticket.CSO"
                                                v-model="personnel_data.required_ticket.CSO"
                                                type="text"
                                                :id="'show_CSOInput-' + properties.type"
                                                class="form-control form-control"
                                                placeholder="Details - if any"
                                            />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="d-flex align-items-center">
                                            <input @click="checkboxToggle('other_ticket', 'show_otherTickerInput')" v-bind:checked="personnel_data.required_ticket.other_ticket" :id="'show_otherTickerCheckbox-'+ properties.type" type="checkbox" class="mr-2" />
                                            <label :for="'show_otherTickerCheckbox-'+ properties.type" class="mb-0 mr-2">Other</label>
                                            <input
                                                v-show="show_otherTickerInput || personnel_data.required_ticket.other_ticket"
                                                v-model="personnel_data.required_ticket.other_ticket"
                                                type="text"
                                                :id="'show_otherTickerInput-'+ properties.type"
                                                class="form-control form-control"
                                                placeholder="Details - if any"
                                            />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="d-flex align-items-center">
                                            <input
                                                v-model="personnel_data.required_ticket.whmis"
                                                value="1"
                                                @click="checkboxToggle('whmis', 'show_otherWhmis')"
                                                v-bind:checked="personnel_data.required_ticket.whmis"
                                                :id="'show_whmisCheckbox-'+ properties.type"
                                                type="checkbox"
                                                class="mr-2"
                                            />
                                            <label :for="'show_otherWhmis-'+ properties.type" class="mb-0 mr-2">Whmis</label>
                                        </div>
                                    </div>
                                </div>
                            
                                <div class="col-lg-3">

                                    <h4 class="card-title mb-4" style="font-size: 13px;">Orientations Required</h4>                            
                                    <div class="form-group">
                                        <div style="display: flex; align-items: center;">
                                            <input @click="checkboxToggle('hours_of_orientation_on_site', 'show_customCheckboxOnsite')" v-bind:checked="personnel_data.hours_of_orientation_on_site" type="checkbox" :id="'show_customCheckboxOnsite-' + properties.type" class="mr-2">
                                            <label :for="'show_customCheckboxOnsite-' + properties.type" class="mb-0 mr-2">On Site</label>
                                            <input
                                                v-show="personnel_data.hours_of_orientation_on_site || show_customCheckboxOnsite"
                                                v-model="personnel_data.hours_of_orientation_on_site"
                                                type="number"
                                                placeholder="Number of hours required"
                                                class="form-control"
                                            />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div style="display: flex; align-items: center;">
                                            <input @click="checkboxToggle('hours_of_orientation_online', 'show_customCheckboxOnline')" v-bind:checked="personnel_data.hours_of_orientation_online" type="checkbox" :id="'show_customCheckboxOnline-' + properties.type" class="mr-2">
                                            <label :for="'show_customCheckboxOnline-' + properties.type" class="mb-0 mr-2">Online</label>
                                            <input
                                                v-show="personnel_data.hours_of_orientation_online || show_customCheckboxOnline"
                                                v-model="personnel_data.hours_of_orientation_online"
                                                type="number"
                                                placeholder="Number of hours required"
                                                class="form-control"
                                            />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-5">

                                    <div style="border: 1px solid rgba(0,0,0,.1); border-radius: 4px; padding: 20px;">
                                        <div class="form-group">
                                            <label class="d-block">Accomodations</label>
                                            <select v-model="personnel_data.accomodation" class="custom-select">
                                                <option>Camp</option>
                                                <option>Hotel</option>
                                                <option>Arranged by Primus</option>
                                                <option>Other</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label :for="'CustomCheckWorkCondition-' + properties.type">Work Conditions</label>
                                            <input v-model="personnel_data.work_conditions" type="input" :id="'CustomCheckWorkCondition-' + properties.type" class="form-control" placeholder="Remote, Outdoors, Long shifts, Heights etc">
                                        </div>

                                        <div class="form-group">
                                            <label  :for="'specializedPPE-' + properties.type">Specialized PPE required?</label>
                                            <input v-model="personnel_data.specialized_PPE" type="input" :id="'specializedPPE-' + properties.type" class="form-control">
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </div>
                    <div class="tab-pane" v-bind:class="{'active' : page == 3}">
                        
                        <div class="alert alert-danger alert-icon" v-show="personnel_data.error">
                            <i class="bx bx-error"></i> <strong>Oops</strong>! {{ personnel_data.error }}
                        </div>

                        <div class="row justify-content-center">
                            <div class="col-lg-6">
                                <div class="text-center d-flex align-items-center" style="min-height: 260px;">
                                    <div class="w-100">
                                        <h4 class="card-title mb-4" style="font-size: 13px;">Drug and Alcohol Test</h4>
                                        <div class="form-group">
                                            <select class="custom-select" v-model="personnel_data.drug_and_alcohol_test.test" @change="changeDrugTest()">
                                                <option value="8 Panel Express">8 Panel Express</option>
                                                <option value="12 Panel Express">12 Panel Express</option>
                                                <option value="8 Panel Lab Based">8 Panel Lab Based</option>
                                                <option value="12 Panel Lab Based">12 Panel Lab Based</option>
                                                <option value="No">No</option>
                                                <option value="Other">Other</option>
                                            </select>
                                        </div>
                                        <div class="text-left" style="border: 1px solid rgba(0,0,0,.1); padding: 20px;">
                                            <strong class="d-block mb-3">Please Fill in the following:</strong>
                                            <div class="form-group">
                                                <div class="d-flex align-items-center">
                                                    <label class="mb-0 mr-1" for="CustomCheckCannabis">Is Cannabis Swap Acceptable</label>
                                                    <input v-model="personnel_data.drug_and_alcohol_test.is_cannabis_swap_acceptable" type="checkbox" id="CustomCheckCannabis" :disabled="disable_canabis_and_recent">
                                                </div>                                                    
                                            </div>
                                            <div class="form-group">
                                                <label for="basicpill-recent" class="">How Recent?</label>
                                                <select v-model="personnel_data.drug_and_alcohol_test.how_recent" class="custom-select" id="basicpill-recent" :disabled="disable_canabis_and_recent">
                                                    <option>Within 30 days</option>
                                                    <option>Within 60 days</option>
                                                    <option>Within 90 days</option>
                                                    <option>Within 1 year</option>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label :for="'CustomCheckMask-' + properties.type">Mask Fit Requirements - Please enter any mask related details</label>
                                                <input v-model="personnel_data.drug_and_alcohol_test.mask_fit_requirements" type="input" :id="'CustomCheckMask-' + properties.type" class="form-control" placeholder="Eg. Scott AV-3000 Half Mask">
                                            </div>
                                            <div class="form-group">
                                                <label :id="'customRadioLiftingLabel-' + properties.type">Heavy Lifting Required (More than 60 lbs)</label>
                                                <div class="d-flex">
                                                    <div class="custom-control custom-radio mr-3">
                                                        <input v-model="personnel_data.drug_and_alcohol_test.can_lift_more_than_sixty_pounds" value="1" type="radio" :id="'yescanliftsixty-' + properties.type" :name="'canliftmorethansixtypounds-' + properties.type" class="custom-control-input">
                                                        <label class="custom-control-label" :for="'yescanliftsixty-' + properties.type">Yes</label>
                                                    </div>
                                                    <div class="custom-control custom-radio">
                                                        <input v-model="personnel_data.drug_and_alcohol_test.can_lift_more_than_sixty_pounds" value="0" type="radio" :id="'nocanliftsixty-' + properties.type" :name="'canliftmorethansixtypounds-' + properties.type" class="custom-control-input">
                                                        <label class="custom-control-label" :for="'nocanliftsixty-' + properties.type">No</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane" v-bind:class="{'active' : page == 4}">
                        
                        <div class="alert alert-danger alert-icon" v-show="personnel_data.error">
                            <i class="bx bx-error"></i> <strong>Oops</strong>! {{ personnel_data.error }}
                        </div>
                        
                        <div class="row mb-4" v-if="properties && properties.type && properties.type === 'operators'">
                            <div class="col-md-12">
                                <div class="d-flex" style="border: 1px solid rgba(0,0,0,.1); border-radius: 4px;">
                                    <div style="flex: 1; padding: 20px;">

                                            <div class="form-group">
                                                <label :id="'labelDriverLicenseRequirements-' + properties.type">Driver License Requirements</label>
                                                <div class="d-flex align-items-center">
                                                    <input type="checkbox" id="a" class="mr-2" v-model="personnel_data.operator_requirement.driver_requirements" value="1">
                                                    <label class="mb-0" for="a">1</label>
                                                </div>
                                                <div class="d-flex align-items-center">
                                                    <input type="checkbox" id="aa" v-model="personnel_data.operator_requirement.driver_requirements" class="mr-2" value="2">
                                                    <label class="mb-0" for="aa">2</label>
                                                </div>
                                                <div class="d-flex align-items-center">
                                                    <input type="checkbox" id="aaa" v-model="personnel_data.operator_requirement.driver_requirements" class="mr-2" value="3">
                                                    <label class="mb-0" for="aaa">3</label>
                                                </div>
                                                <div class="d-flex align-items-center">
                                                    <input type="checkbox" id="aaaa" v-model="personnel_data.operator_requirement.driver_requirements" class="mr-2" value="4">
                                                    <label class="mb-0" for="aaaa">4</label>
                                                </div>
                                                <div class="d-flex align-items-center">
                                                    <input type="checkbox" id="aaaaa" v-model="personnel_data.operator_requirement.driver_requirements" class="mr-2" value="5">
                                                    <label class="mb-0" for="aaaaa">5</label>
                                                </div>
                                                <div class="d-flex align-items-center">
                                                    <input type="checkbox" id="aaaaa" v-model="personnel_data.operator_requirement.driver_requirements" class="mr-2" value="6">
                                                    <label class="mb-0" for="aaaaa">6</label>
                                                </div>
                                                <div class="d-flex align-items-center">
                                                    <input type="checkbox" id="aaaaaa" v-model="personnel_data.operator_requirement.driver_requirements" class="mr-2" value="Q (Airbrakes Endorsement)">
                                                    <label class="mb-0" for="aaaaaa">Q (Airbrakes Endorsement)</label>
                                                </div>                                         
                                            </div>

                                            <div class="form-group">
                                                <label :for="'basicpill-abstract-' + properties.type" class="">Driver’s Abstract</label>
                                                <select v-model="personnel_data.operator_requirement.driver_abstract" class="custom-select" :id="'basicpill-abstract' + properties.type">
                                                    <option>3 Years Commercial</option>
                                                    <option>5 Years Commercial</option>
                                                    <option>Not Required</option>
                                                </select>
                                            </div>

                                            <template class="form-group" v-if="personnel_data.operator_requirement.driver_abstract === '3 Years Commercial' || personnel_data.driver_abstract === '5 Years Commercial' ">
                                                <div class="form-group">
                                                    <label :for="'demeritPoints-' + properties.type">The number of Demerit Points Acceptable</label>
                                                    <input v-model="personnel_data.operator_requirement.demerit_points_acceptable" type="number" :id="'demeritPoints-' + properties.type" class="form-control">
                                                </div>
                                            </template>

                                    </div>
                                    <div style="flex: 1; padding: 20px; border-left: 1px solid rgba(0,0,0,.1); border-right: 1px solid rgba(0,0,0,.1);">

                                            <div style="display:none;" class="form-group">
                                                <label :for="'licenseClass-' + properties.type">License Class</label>
                                                <input v-model="personnel_data.operator_requirement.license_class" type="number" :id="'licenseClass-' + properties.type" class="form-control">
                                            </div>

                                            <div class="form-group">
                                                <label :id="'labelOffRoadNeeded-' + properties.type">Off-road needed</label>
                                                <div class="d-flex">
                                                    <div class="custom-control custom-radio mr-3">
                                                        <input v-model="personnel_data.operator_requirement.is_off_road_needed" value="1" type="radio" :id="'customRadioOffRoadYes-' + properties.type" class="custom-control-input" name="offroad">
                                                        <label class="custom-control-label" :for="'customRadioOffRoadYes-' + properties.type">Yes</label>
                                                    </div>
                                                    <div class="custom-control custom-radio">
                                                        <input v-model="personnel_data.operator_requirement.is_off_road_needed" value="0" type="radio" :id="'customRadioOffRoadNo-' + properties.type" class="custom-control-input" name="offroad">
                                                        <label class="custom-control-label" :for="'customRadioOffRoadNo-' + properties.type">No</label>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label :id="'labelChainupNeeded-' + properties.type">Chain-up needed</label>
                                                <div class="d-flex">
                                                    <div class="custom-control custom-radio mr-3">
                                                        <input v-model="personnel_data.operator_requirement.is_chain_up_needed" value="1" type="radio" id="customRadioChainYes" class="custom-control-input" name="chainup">
                                                        <label class="custom-control-label" for="customRadioChainYes">Yes</label>
                                                    </div>
                                                    <div class="custom-control custom-radio">
                                                        <input v-model="personnel_data.operator_requirement.is_chain_up_needed" value="0" type="radio" id="customRadioChainNo" class="custom-control-input" name="chainup">
                                                        <label class="custom-control-label" for="customRadioChainNo">No</label>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label :id="'labelOffMountainExpNeeded-' + properties.type">Mountain experience</label>
                                                <div class="d-flex">
                                                    <div class="custom-control custom-radio mr-3">
                                                        <input v-model="personnel_data.operator_requirement.mountain_experience" value="1" type="radio" id="customRadioMountainYes" class="custom-control-input" name="mountain_experience">
                                                        <label class="custom-control-label" for="customRadioMountainYes">Yes</label>
                                                    </div>
                                                    <div class="custom-control custom-radio">
                                                        <input v-model="personnel_data.operator_requirement.mountain_experience" value="0" type="radio" id="customRadioMountainNo" class="custom-control-input" name="mountain_experience">
                                                        <label class="custom-control-label" for="customRadioMountainNo">No</label>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label :id="'labelRadioCallingNeeded-' + properties.type">Radio Calling Experience</label>
                                                <div class="d-flex">
                                                    <div class="custom-control custom-radio mr-3">
                                                        <input v-model="personnel_data.operator_requirement.radio_calling_experience" value="1" type="radio" id="customRadioCallingYes" class="custom-control-input" name="radio_calling_experience">
                                                        <label class="custom-control-label" for="customRadioCallingYes">Yes</label>
                                                    </div>
                                                    <div class="custom-control custom-radio">
                                                        <input v-model="personnel_data.operator_requirement.radio_calling_experience" value="0" type="radio" id="customRadioCallingNo" class="custom-control-input" name="radio_calling_experience">
                                                        <label class="custom-control-label" for="customRadioCallingNo">No</label>
                                                    </div>
                                                </div>
                                            </div>
                                    </div>

                                    <div style="flex: 1; padding: 20px;">
                                            <div class="form-group">
                                                <label :id="'labelDispatchApps-' + properties.type">Dispatch Apps for smart phone required</label>
                                                <div class="d-flex">
                                                    <div class="custom-control custom-radio mr-3">
                                                        <input v-model="personnel_data.operator_requirement.dispatch_apps_for_smartphone_required" value="1" type="radio" id="customRadioDispatchYes"  class="custom-control-input" name="dispatch_apps_for_smartphone_required">
                                                        <label class="custom-control-label" for="customRadioDispatchYes">Yes</label>
                                                    </div>
                                                    <div class="custom-control custom-radio">
                                                        <input v-model="personnel_data.operator_requirement.dispatch_apps_for_smartphone_required" value="0" type="radio" id="customRadioDispatchNo" class="custom-control-input" name="dispatch_apps_for_smartphone_required">
                                                        <label class="custom-control-label" for="customRadioDispatchNo">No</label>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label :id="'labelTransmissionType-' + properties.type">Transmission Type</label>
                                                <div class="d-flex align-items-center">
                                                    <input v-model="personnel_data.operator_requirement.transmission_type" value="automatic" type="checkbox" id="CustomCheckAutomatic" class="mr-2">
                                                    <label class="mb-0" for="CustomCheckAutomatic">Automatic</label>
                                                </div>
                                                <div class="d-flex align-items-center">
                                                    <input v-model="personnel_data.operator_requirement.transmission_type" value="manual" type="checkbox" id="CustomCheckManual" class="mr-2">
                                                    <label class="mb-0" for="CustomCheckManual">Manual</label>
                                                </div>                                          
                                            </div>

                                            <div class="form-group">
                                                <label :for="'basicpill-hours' + properties.type" class="">Hours of Service</label>
                                                <select v-model="personnel_data.operator_requirement.hours_of_service" class="custom-select" :id="'basicpill-hours' + properties.type">
                                                    <option>Federal</option>
                                                    <option>Provincial</option>
                                                    <option>Exempt</option>
                                                </select>
                                            </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-lg-12">
                                <div style="border: 1px solid rgba(0, 0, 0, 0.1); border-radius: 4px; padding: 20px;">
                                    <h4 class="card-title mb-4" style="font-size: 13px;">Additional Details:</h4>
                                    <div class="form-group">
                                        <label :for="'CustomAdditionalDetails-' + properties.type">Additional Pre Employment Requirements</label>
                                        <textarea v-model="personnel_data.pre_employments" type="input" :id="'CustomAdditionalDetails-' + properties.type" class="form-control" placeholder="RCMP Clearance checks, fitness to work, able to lift 50 lbs, etc" style="height: 120px;"></textarea>
                                    </div>

                                    <!--<div class="form-group">
                                        <label for="jobDescriptionlTextarea1">Job Description</label>
                                        <textarea v-model="personnel_data.job_description" class="form-control" id="jobDescriptionlTextarea1" rows="3" style="min-height: 150px;" placeholder="Write your description here.."></textarea>
                                    </div>
                                    <div class="d-flex align-items-center" style="display: none !important;">
                                        <label for="attachFile" class="mb-0 mr-1">Attach File:</label>
                                        <input multiple="multiple" type="file" autocomplete="off" id="attachFile">
                                    </div>-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </diV>
</template>
<script>
import moment from 'moment'

export default {
    
    name: 'personnel-form',
    props: ['properties'],
    data: function () {
        return {
            subcategories: [],

            // for checkboxes with text fields
            show_firstAidInput: false,
            show_H2SInput: false,
            show_CSTSInput: false,
            show_CofinedSpaceInput: false,
            show_groundDisInput: false,
            show_fallArresetInput: false,
            show_CSOInput: false,
            show_otherTickerInput: false,
            show_otherWhmis:false,

            show_customCheckboxOnsite: false,
            show_customCheckboxOnline: false,
            disable_canabis_and_recent: false,
            
            personnel_data: {
                // personnel required
                id: null,
                type : '',
                scope_of_work : '',
                shift_duration : '',
                percentage_of_people_on_day_shift : 0,

                hours_of_orientation_on_site : '',
                hours_of_orientation_online : '',
                accomodation : "Camp",
                pre_employments : '',
                work_conditions : '',
                specialized_PPE : '',


                // personnel operator
                operator_requirement: {
                    license_class : '',
                    driver_abstract : '3 Years Commercial',
                    demerit_points_acceptable : '',
                    driver_requirements : [],
                    hours_of_service : 'Federal',
                    is_off_road_needed : '',
                    is_chain_up_needed : '',
                    mountain_experience : '',
                    radio_calling_experience : '',
                    dispatch_apps_for_smartphone_required : '',
                    transmission_type : [],
                },

                // required tickets
                required_ticket: {
                    first_aid: '',
                    H2S_alive: '',
                    CSTS: '',
                    confined_space: '',
                    ground_disturbance: '',
                    fall_arrest: '',
                    CSO: '',
                    other_ticket: '',
                    whmis: '',
                },


                // drug and alcohol
                drug_and_alcohol_test: {
                    test: '8 Panel Express',
                    is_cannabis_swap_acceptable: '',
                    how_recent : 'Within 30 days',
                    mask_fit_requirements : '',
                    can_lift_more_than_sixty_pounds : '',
                },

                
                
                personnel_details: [
                    {
                        id: null,
                        job_title: '',
                        quantity:'',
                        personnel: '',
                        job_description:'',
                        skills: [],
                    }
                ],
                error: null,
            },
            reset_personnel_data: {},
            tab_counter: 1,
            tab_prev_limit: 1,
            tab_next_limit: 4,

            tab_percent: 25,
            page: 1,

        }
    },
    methods: {
        getSubcategories: function () {
            var scope = this
            scope.subcategories = []
            var response = scope.GET('job-subcategories',scope.formdata).then(res => {
                scope.subcategories = res.rows
            })
        },
        isSkillSelected: function (job_type_id, index_details) {
            var scope = this
            return scope.personnel_data.personnel_details[index_details].skills.includes(job_type_id);
        },
        toggleSkill: function (job_type_id, index_details) {
            var scope = this


            if (!scope.isSkillSelected(job_type_id, index_details)) {
                scope.personnel_data.personnel_details[index_details].skills.push(job_type_id)
            } else {
                const index = scope.personnel_data.personnel_details[index_details].skills.indexOf(job_type_id);
                scope.personnel_data.personnel_details[index_details].skills.splice(index, 1);
            }
        },
        next: function (page, pages) {
            var scope = this
            scope.page = page
            var percentage =  page * (100 / pages)

            var dom = '.personnel-form-wrap .progress #progress-' + scope.properties.type
            $(document).find(dom).css('width', `${percentage}%`)
            return

        },
        changeDrugTest: function(){
            var scope = this
            scope.disable_canabis_and_recent = (scope.personnel_data.drug_and_alcohol_test.test == 'No') ? true : false
        },
         toTitleCase: function(str){
            return str.replace(
                /\w\S*/g,
                function(txt) {
                return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
                }
            );
        },
        addPersonnelDetails: function(){
            var scope = this

            scope.personnel_data.personnel_details.push({
                id: null,
                job_title: '',
                quantity:'',
                personnel:'',
                job_description:'',
                skills: []
            })
        }
        ,
        deletePersonnelDetails(index) {
            var scope = this
            scope.personnel_data.personnel_details.splice(index,1)
        },
        prev: function (page, pages) {
            // perpare: bsin naay naka lahi sa next...
            var scope = this
            scope.page = page
            var percentage =  page * (100 / pages)

            var dom = '.personnel-form-wrap .progress #progress-' + scope.properties.type
            $(document).find(dom).css('width', `${percentage}%`)
            return
        },
        getPersonnelData: function () {
            var scope = this
            scope.personnel_data.type = scope.properties.type
            return scope.personnel_data
        },
        done: function () {
            var scope = this

                if(scope.show_firstAidInput == true && scope.personnel_data.required_ticket.first_aid == '' ){
                    scope.personnel_data.required_ticket.first_aid = 'yes';
                }
                if(scope.show_H2SInput == true && scope.required_ticket.personnel_data.H2S_alive == '' ){
                    scope.personnel_data.required_ticket.H2S_alive = 'yes';
                }
                if(scope.show_CSTSInput == true && scope.personnel_data.required_ticket.CSTS == '' ){
                    scope.personnel_data.required_ticket.CSTS = 'yes';
                }
                if(scope.show_CofinedSpaceInput == true && scope.personnel_data.required_ticket.confined_space == '' ){
                    scope.personnel_data.required_ticket.confined_space = 'yes';
                }
                if(scope.show_groundDisInput == true && scope.personnel_data.required_ticket.ground_disturbance == '' ){
                    scope.personnel_data.required_ticket.ground_disturbance = 'yes';
                }
                if(scope.show_fallArresetInput == true && scope.personnel_data.required_ticket.fall_arrest == '' ){
                    scope.personnel_data.required_ticket.fall_arrest = 'yes';
                }
                if(scope.show_CSOInput == true && scope.personnel_data.required_ticket.CSO == '' ){
                    scope.personnel_data.required_ticket.CSO = 'yes';
                }
                if(scope.show_otherTickerInput == true && scope.personnel_data.required_ticket.other_ticket == '' ){
                    scope.personnel_data.required_ticket.other_ticket = 'yes';
                }


            scope.personnel_data.type = scope.properties.type
            scope.$emit('done', scope.personnel_data)
        },
        /*resetPersonnelData: function () {
            var scope = this
            scope.personnel_data = scope.reset_personnel_data
        },*/
        checkboxToggle: function (data_model, show_input) {
            var scope = this


            // in 'edit': if toggled turn to empty
            if(scope.personnel_data[data_model]) {
                scope.personnel_data[data_model] = ''
                scope[show_input] = false
            }else{
                // if 'add'
                scope[show_input] = !scope[show_input]

            }
        },
    },
    mounted () {
        var scope = this
        $(document).off('click','.pr-core-comp-single-header').on('click','.pr-core-comp-single-header',function(){
            var CORE_COMPETENCY_SINGLE = $(this).closest('.pr-core-comp-single')
            if (CORE_COMPETENCY_SINGLE.hasClass('active')) {
                CORE_COMPETENCY_SINGLE.removeClass('active')
            } else {
                CORE_COMPETENCY_SINGLE.addClass('active')
            }
        });

        scope.getSubcategories()

        if (scope.properties && scope.properties.personnel && scope.properties.personnel.required_ticket) {
            scope.personnel_data = scope.properties.personnel
            
            // required tickets
            scope.personnel_data.required_ticket.first_aid =          (scope.properties && scope.properties.personnel && scope.properties.personnel.required_ticket) ? scope.properties.personnel.required_ticket.first_aid : ''
            scope.personnel_data.required_ticket.H2S_alive =          (scope.properties && scope.properties.personnel && scope.properties.personnel.required_ticket) ? scope.properties.personnel.required_ticket.H2S_alive : ''
            scope.personnel_data.required_ticket.CSTS =               (scope.properties && scope.properties.personnel && scope.properties.personnel.required_ticket) ? scope.properties.personnel.required_ticket.CSTS : ''
            scope.personnel_data.required_ticket.confined_space =     (scope.properties && scope.properties.personnel && scope.properties.personnel.required_ticket) ? scope.properties.personnel.required_ticket.confined_space : ''
            scope.personnel_data.required_ticket.ground_disturbance = (scope.properties && scope.properties.personnel && scope.properties.personnel.required_ticket) ? scope.properties.personnel.required_ticket.ground_disturbance : ''
            scope.personnel_data.required_ticket.fall_arrest =        (scope.properties && scope.properties.personnel && scope.properties.personnel.required_ticket) ? scope.properties.personnel.required_ticket.fall_arrest : ''
            scope.personnel_data.required_ticket.CSO =                (scope.properties && scope.properties.personnel && scope.properties.personnel.required_ticket) ? scope.properties.personnel.required_ticket.CSO : ''
            scope.personnel_data.required_ticket.other_ticket =       (scope.properties && scope.properties.personnel && scope.properties.personnel.required_ticket) ? scope.properties.personnel.required_ticket.other_ticket : ''

            // drug and alcohol 
            scope.personnel_data.test =                            (scope.properties && scope.properties.personnel && scope.properties.personnel.drug_and_alcohol_test) ? scope.properties.personnel.drug_and_alcohol_test.test : ''
            scope.personnel_data.is_cannabis_swap_acceptable =     (scope.properties && scope.properties.personnel && scope.properties.personnel.drug_and_alcohol_test) ? scope.properties.personnel.drug_and_alcohol_test.is_cannabis_swap_acceptable : ''
            scope.personnel_data.how_recent =                      (scope.properties && scope.properties.personnel && scope.properties.personnel.drug_and_alcohol_test) ? scope.properties.personnel.drug_and_alcohol_test.how_recent : ''
            scope.personnel_data.mask_fit_requirements =           (scope.properties && scope.properties.personnel && scope.properties.personnel.drug_and_alcohol_test) ? scope.properties.personnel.drug_and_alcohol_test.mask_fit_requirements : ''
            scope.personnel_data.can_lift_more_than_sixty_pounds = (scope.properties && scope.properties.personnel && scope.properties.personnel.drug_and_alcohol_test) ? scope.properties.personnel.drug_and_alcohol_test.can_lift_more_than_sixty_pounds : ''

            if(scope.properties.personnel.type === 'operators') {
                // personnel operator
                scope.personnel_data.license_class =            (scope.properties && scope.properties.personnel.operator_requirement) ? scope.properties.personnel.operator_requirement.license_class : ''
                scope.personnel_data.driver_abstract =          (scope.properties && scope.properties.personnel.operator_requirement) ? scope.properties.personnel.operator_requirement.driver_abstract : ''
                scope.personnel_data.demerit_points_acceptable =(scope.properties && scope.properties.personnel.operator_requirement) ? scope.properties.personnel.operator_requirement.demerit_points_acceptable : ''
                scope.personnel_data.driver_requirements =      (scope.properties && scope.properties.personnel.operator_requirement) ?  JSON.parse(scope.properties.personnel.operator_requirement.driver_requirements) : ''
                scope.personnel_data.hours_of_service =         (scope.properties && scope.properties.personnel.operator_requirement) ? scope.properties.personnel.operator_requirement.hours_of_service : ''
                scope.personnel_data.is_off_road_needed =       (scope.properties && scope.properties.personnel.operator_requirement) ? scope.properties.personnel.operator_requirement.is_off_road_needed : ''
                scope.personnel_data.is_chain_up_needed =       (scope.properties && scope.properties.personnel.operator_requirement) ? scope.properties.personnel.operator_requirement.is_chain_up_needed : ''
                scope.personnel_data.mountain_experience =      (scope.properties && scope.properties.personnel.operator_requirement) ? scope.properties.personnel.operator_requirement.mountain_experience : ''
                scope.personnel_data.radio_calling_experience = (scope.properties && scope.properties.personnel.operator_requirement) ? scope.properties.personnel.operator_requirement.radio_calling_experience : ''
                scope.personnel_data.dispatch_apps_for_smartphone_required =  (scope.properties && scope.properties.personnel.operator_requirement) ? scope.properties.personnel.operator_requirement.dispatch_apps_for_smartphone_required : ''
                scope.personnel_data.transmission_type =        (scope.properties && scope.properties.personnel.operator_requirement) ? JSON.parse(scope.properties.personnel.operator_requirement.transmission_type) : ''
            }
        }
    }
}
</script>
<style scoped>
    .tickets-orientations-row { white-space: nowrap; }

    .card-header {
        padding: .75rem 1.25rem;
        margin-bottom: 0;
        background-color: #ffffff;
        border: 1px solid #dde0e4;
    }

    .collapse {
        border: 1px solid #dde0e4;
    }
    .text-black{
        color: black;
    }
    .text-md{
        font-size: 17px;
    }

    .text-lg{
        font-size: 20px;
    }


    .pr-core-comp-wrap { padding:10px 15px; }
    .pr-core-comp-wrap .pr-core-comp-header { padding:8px 10px; border-radius:4px; border-bottom-right-radius:0px; border-bottom-left-radius:0px; background:#f8f9fa; border:1px solid #ccc; }
    .pr-core-comp-wrap .pr-core-comp-header h4 { font-size:14px; font-weight:600;  margin:0px; }
    .pr-core-comp-wrap .pr-core-comp-body { padding:5px 10px; border-radius:0px; border-bottom-right-radius:3px; border-bottom-left-radius:3px; background:#fff; border:1px solid #ccc; border-top:none;  }
    .pr-core-comp-wrap .pr-core-comp-body .pr-core-comp-single-header { cursor:pointer; background:#fafafa; border:1px solid #efefef; padding:5px 10px; position:relative; padding-right:80px;  margin-top:5px;  }
    .pr-core-comp-wrap .pr-core-comp-body .pr-core-comp-single-header span { font-weight:600; }
    .pr-core-comp-wrap .pr-core-comp-body .pr-core-comp-single-header .pr-core-comp-icon { position:absolute; top:0px; right:5px; }
    .pr-core-comp-wrap .pr-core-comp-body .pr-core-comp-single-header .pr-core-comp-icon i { font-size:18px; color:#aaa;  }
    .pr-core-comp-wrap .pr-core-comp-body .pr-core-comp-single-header .pr-core-comp-icon i.mdi-minus-circle { display:none;  }

    .pr-core-comp-wrap .pr-core-comp-body .pr-core-comp-single-body { display:none; padding:10px 10px; border:1px solid #efefef; border-top:none;  }

    .pr-core-comp-wrap .pr-core-comp-body .pr-core-comp-single.active .pr-core-comp-single-body { display:block;   }
    .pr-core-comp-wrap .pr-core-comp-body .pr-core-comp-single.active .pr-core-comp-single-body { display:block;   }
    .pr-core-comp-wrap .pr-core-comp-body .pr-core-comp-single.active .pr-core-comp-icon i.mdi-minus-circle { display:inline-block;  }
    .pr-core-comp-wrap .pr-core-comp-body .pr-core-comp-single.active .pr-core-comp-icon i.mdi-plus-circle { display:none;  }



</style>