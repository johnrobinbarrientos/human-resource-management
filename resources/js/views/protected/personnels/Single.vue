<template>
<div v-if="request && request.personnel" class="confirm-submit">
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-lg-4">
                            <strong>Basic Details:</strong>
                            <span>Request ID: {{ request.request_id }}</span>
                            <span>Request Date: {{ request.date }}</span>
                            <span>Job Location: {{ request.job_location }}</span>
                            <span>Site Location: {{ request.site_location }}</span>
                            <span>Estimated Work Start Date: {{ request.estimated_start_date }}</span>
                            <span>Estimated Work End Date: {{ request.estimated_end_date }}</span>
                        </div>
                        <div class="col-lg-4">
                            <template v-if="request.company">
                                <strong>Company Details:</strong>
                                <span>Company Name: {{ request.company.name }}</span>
                                <span>Email: {{ request.company.email }}</span>
                                <span>Contact #: {{ request.company.phone }}</span>
                            </template>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <div v-if="request.personnel.length" id="accordion">
                <div v-for="(person, index) in request.personnel" :key="index" class="mb-1 card">
                    <div @click="toggleAccordion(index + 1)" id="headingOne" class="card-header" style="padding: .5rem 1.25rem">
                        <div class="d-flex justify-content-between align-items-center">
                            <strong class="m-0 font-14"><span class="text-capitalize">{{ person.type }}</span></strong>
                            <i class="bx bx-chevron-down" style="font-size: 29px"></i>
                        </div>
                    </div>
                    <div class="collapse" style="">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-lg-4">
                                        <strong>Work Shift Details</strong>
                                        <span>Shift Duration (Hours per day/per shift): {{ person.shift_duration }}</span>
                                        <span>Percentage of people on day shift: {{ person.percentage_of_people_on_day_shift }}</span>
                                        <span>Scope of Work: {{ person.scope_of_work }}</span><br>

                                        <strong>Tickets Required</strong>
                                        <template v-if="person.required_ticket">
                                            <span v-if="person.required_ticket.first_aid">First Aid: {{ person.required_ticket.first_aid }}</span>
                                            <span v-if="person.required_ticket.H2S_alive">H2S Alive: {{ person.required_ticket.H2S_alive }}</span>
                                            <span v-if="person.required_ticket.CSTS">CSTS: {{ person.required_ticket.CSTS }}</span>
                                            <span v-if="person.required_ticket.confined_space">Confined Space: {{ person.required_ticket.confined_space }}</span>
                                            <span v-if="person.required_ticket.ground_disturbance">Ground Disturbance: {{ person.required_ticket.ground_disturbance }}</span>
                                            <span v-if="person.required_ticket.fall_arrest">Fall Arrest: {{ person.required_ticket.fall_arrest }}</span>
                                            <span v-if="person.required_ticket.CSO">CSO (BSO/eGSO/PST): {{ person.required_ticket.CSO }}</span>
                                            <span v-if="person.required_ticket.other_ticket">Other: {{ person.required_ticket.other_ticket }}</span><br>
                                            <span v-if="person.required_ticket.whmis">Whmis: Yes</span>
                                            <span v-else>Whmis: No</span><br>
                                        </template>
                                        
                                        <strong>Hours of Orientation</strong>
                                        <span>On Site: {{ person.hours_of_orientation_on_site }} hour(s)</span>
                                        <span class="d-flex">
                                            <span class="mr-1">Online:</span>
                                            <span v-if="person.hours_of_orientation_online">{{ person.hours_of_orientation_online }} hour(s)</span>
                                            <span v-else>N/A</span>
                                        </span>
                                    </div>

                                    <div class="col-lg-4">

                                        <strong>Additional Details/Requirements</strong>
                                        <span>Accomodation: {{ person.accomodation }}</span>
                                        <span>Work Conditions: {{ person.work_conditions }}</span>
                                        <span>Specialized PPE required?: {{ person.specialized_PPE }}</span>
                                        <br>

                                        <template v-if="person.drug_and_alcohol_test">
                                            <strong>Drug and Alcohol Test</strong>
                                            <span>Test: {{ person.drug_and_alcohol_test.test }}</span>
                                            <span>Is Cannabis Swap Acceptable: {{ person.drug_and_alcohol_test.is_cannabis_swap_acceptable }}</span>
                                            <span>How Recent?: {{ person.drug_and_alcohol_test.how_recent }}</span>
                                            <span>Mask Fit Requirements: {{ person.drug_and_alcohol_test.mask_fit_requirements }}</span>
                                            <span v-if="person.drug_and_alcohol_test.can_lift_more_than_sixty_pounds == 1">Heavy Lifting Required (More than 60 lbs): Yes</span>
                                            <span v-else>Heavy Lifting Required (More than 60 lbs): No</span>
                                        </template>
                                    </div>
                                    <div v-if="person.type === 'operators'" class="col-lg-4">
                                        <div v-if="person.operator_requirement">
                                            <strong>Requirements, Experiences etc.</strong>


                                            <span>Driver Requirements: </span>
                                            <ul class="pl-4">
                                                <li v-for="(driver_requirement, index) in person.operator_requirement.driver_requirements" :key="index">{{ driver_requirement }}</li>
                                            </ul>

                                            <span>Transmission Type:</span>
                                            <ul class="pl-4">
                                                <li v-for="(type, index) in person.operator_requirement.transmission_type" :key="index">{{ type }}</li>
                                            </ul>


                                            <span>Driver’s Abstract: {{ person.operator_requirement.driver_abstract }}</span>
                                            <span>The number of Demerit Points Acceptable: {{ person.operator_requirement.demerit_points_acceptable }}</span>
                                            <span>License Class:</span>
                                            <ul class="pl-4">
                                                <li v-for="(driver_requirement, index) in person.operator_requirement.driver_requirements" :key="index">{{ driver_requirement }}</li>
                                            </ul>

                                            <span v-if="person.operator_requirement.is_off_road_needed == '1'">Off-road needed: Yes</span>
                                            <span v-else>Off-road needed: No</span>

                                            <span v-if="person.operator_requirement.is_chain_up_needed == '1'">Chain-up needed: Yes</span>
                                            <span v-else>Chain-up needed: No</span>

                                            <span v-if="person.operator_requirement.mountain_experience == '1'">Mountain experience: Yes</span>
                                            <span v-else>Mountain experience: No</span>

                                            <span v-if="person.operator_requirement.radio_calling_experience == '1'">Radio Calling Experience: Yes</span>
                                            <span v-else>Radio Calling Experience: No</span>

                                            <span v-if="person.operator_requirement.dispatch_apps_for_smartphone_required == '1'">Dispatch Apps for smart phone required: Yes</span>
                                            <span v-else>Dispatch Apps for smart phone required: No</span>
                                            <span>Hours of Service: {{ person.operator_requirement.hours_of_service }}</span>
                                        </div>
                                    </div>
                                </div>
                                <br>
                                <strong class="mb-2">Personnel Request Details</strong>
                                <div class="details mb-2" v-for="(detail, index_details) in person.personnel_details" :key="index_details">

                                        <div class="pr-core-comp-wrap">
                                            <button v-show="request.request_id && user.type =='Admin'" @click="createJob(detail, person, request)" type="button" class="btn btn-primary float-right" style="">Create Job</button>
                                            <strong class="text-capitalize mb-2">{{ person.type }} No. {{index_details+1}}</strong>
                                            <div class="mb-2"><span>Job Title: {{detail.job_title}}</span></div>
                                            <div class="mb-2"><span>No. of <span class="text-capitalize d-inline">{{ person.type }}</span>: {{detail.quantity}}</span></div>
                                            <div class="mb-2"><span>Job Description: {{detail.job_description}}</span></div>
                                            <br>

                                            <div class="pr-core-comp-header">
                                                <h4>Core Competencies</h4>
                                            </div>
                                            <div class="pr-core-comp-body">
                                                <template v-for="(subcategory, index_sub) in subcategories" >
                                                    <div :key="'cc-single-' + index_sub" class="pr-core-comp-single" :class="{'active': index_sub == 0}">
                                                        <div :key="'cc-header-' + index_sub" class="pr-core-comp-single-header">
                                                            <span>{{ subcategory.name }}</span>

                                                            <div class="pr-core-comp-icon">
                                                                <i class="mdi mdi-plus-circle"></i>
                                                                <i class="mdi mdi-minus-circle"></i>
                                                            </div>
                                                        </div>
                                                        <div :key="'cc-content-' + index_sub" class="pr-core-comp-single-body">
                                                            <div class="row">
                                                                <div v-for="(type, index_types) in subcategory.job_types" :key="'type-' + index_types"  class="col-12 col-sm-6 col-md-4 col-lg-3">
                                                                    <!-- <div class="form-check mb-3">
                                                                        <input onclick="return false;" class="form-check-input" type="checkbox" value="" :id="'type-' + index_types" :checked="isSkillSelected(type.id, index, index_details)" readonly>
                                                                        <label class="form-check-label" :for="'type-' + index_types">
                                                                            {{ type.job_type.name }}
                                                                        </label>
                                                                    </div> -->
                                                                    <template v-if="isSkillSelected(type.id, index, index_details)" >
                                                                        <div class="mb-1 d-flex align-items-center">
                                                                            <i class='bx bxs-check-circle mr-1'></i>
                                                                            <label class="form-check-label" :for="'type-' + index_types">
                                                                                {{ type.job_type.name }}
                                                                            </label>
                                                                        </div>
                                                                    </template>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </template>
                                            </div>
                                        </div>
                                </div>
                                <div class="row mt-4">
                                    <div class="col-lg-12">
                                        <div class="details">
                                            <strong class="mb-2">Additional Pre Employment Requirements:</strong>
                                            {{ person.pre_employments }}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

        </div>

    </div>
</div>

</template>
<script>
export default {
    name: 'personnel-request-single',
    props: ['properties'],
    data: function () {
        return {
            user: [],
            request: {},
            show_accord: false,
            subcategories: [],
            formdata: {
                request_id: null,
                company_id: null,
                title: '',
                type: '',
                job_location: '',
                description: '',
                start_date: '',
                end_date: '',
                skills: [],
            },
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
        isSkillSelected: function (job_type_id, index, index_details) {
            var scope = this

            if (scope.request.personnel[index].personnel_details[index_details].skills.includes(job_type_id)) {
                $('#card-'+index).css('display', 'block')
            }

            return scope.request.personnel[index].personnel_details[index_details].skills.includes(job_type_id);
        },

        createJob: function (detail, person, request_detail) {
            var scope = this

            scope.formdata.request_id = request_detail.id
            scope.formdata.company_id = request_detail.company.id
            
            scope.formdata.job_location = request_detail.job_location
            scope.formdata.start_date = request_detail.estimated_start_date
            scope.formdata.end_date = request_detail.estimated_end_date

            
            if(person.type =='laborers'){
                scope.formdata.type = 'Laborer'
            }else if (person.type =='operators'){
                scope.formdata.type = 'Operator'
            }else if (person.type =='supervisors'){
                scope.formdata.type = 'Supervisor'
            }else if (person.type =='other_personnel'){
                scope.formdata.type = 'Other'
            }
            scope.formdata.title = detail.job_title
            scope.formdata.description = detail.job_description
            scope.formdata.skills = detail.skills


            scope.POST('jobs/request/create', scope.formdata).then(res => {
                if (res.success) {
                    window.swal.fire({
                        position: 'center',
                        icon: 'success',
                        title: 'Successfully Created',
                        showConfirmButton: false,
                        timer: 1500
                    }).then(() => {
                        scope.ROUTE({path: '/jobs/posts'})
                        
                    })
                } else {
                    alert('ERROR:' + res.code)
                }

            })


        },
        toggleAccordion: function(num) {
            var scope = this

            if(scope.show_accord == false)
            {
                $(`#accordion .card:nth-child(${num}) .collapse`).addClass('show')
                return scope.show_accord = true
            }

            $(`#accordion .card:nth-child(${num}) .collapse`).removeClass('show')
            return scope.show_accord = false
        }
    },

    mounted () {
        var scope = this
        scope.getSubcategories()
        scope.request = scope.properties ? scope.properties.request : {}

        scope.user = scope.properties ? scope.properties.user : []


        if (scope.properties.personnel) {
            let personnel = Object.values(scope.properties.personnel)
            personnel = personnel.filter(personnel => personnel.hasOwnProperty('id'))
            scope.request.personnel = personnel
        }

        for (var personnel in scope.request.personnel) {
            if (scope.request.personnel[personnel].operator_requirement) {
                if (typeof scope.request.personnel[personnel].operator_requirement.driver_requirements == 'string') {
                    scope.request.personnel[personnel].operator_requirement.driver_requirements = JSON.parse(scope.request.personnel[personnel].operator_requirement.driver_requirements)
                }
                if (typeof scope.request.personnel[personnel].operator_requirement.transmission_type == 'string') {
                    scope.request.personnel[personnel].operator_requirement.transmission_type = JSON.parse(scope.request.personnel[personnel].operator_requirement.transmission_type)
                }
            }
        }

        $(`#accordion .card:nth-child(1) .collapse`).addClass('show')

    }

        
}
</script>
<style scoped>
ul { margin-bottom: .6rem; }
.card .collapse, .card .collapse.show { transition: .5s; }
.card-header, .card-body { border: 1px solid #ddd; }
.card-header { cursor: pointer; }
.card-body { border-top: 0; }
.confirm-submit span,
.confirm-submit strong { display: block; }
.confirm-submit strong { font-size: 14px; }
.details { border: 1px solid rgba(0,0,0,.1); padding: 10px; border-radius: 6px; }

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


[id*="card-"] {
    display: none;
}

</style>