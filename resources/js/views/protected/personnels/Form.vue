<template>
    <div>
        <div style="background:#fff; padding:10px; border:1px solid #efefef;" class="panel-body">
            <div id="personnel-request-wrap">
            <div id="progrss-wizard" class="twitter-bs-wizard">
                <ul class="twitter-bs-wizard-nav nav-justified nav nav-pills">
                    <li class="nav-item">
                        <a @click="jump(1)" :class="{'active': form.current >= 1}" class="nav-link"><span class="step-number mr-2">01</span><span>Basic Details</span></a>
                    </li>
                    <li @click="jump(index + 2)" class="nav-item"  v-for="(sub,index) in form.subs" :key="'form-sub-' + index">
                        <a v-bind:class="{'active' : form.current >= (index + 2)}"  class="nav-link"><span class="step-number mr-2">0{{ index + 2}}</span><span>{{ sub.title }}</span></a>
                    </li>
                    <li @click="jump(form.subs.length + 2)" class="nav-item">
                        <a :class="{'active': form.current >= (form.subs.length + 2) }" class="nav-link"><span class="step-number mr-2">0{{ form.subs.length + 2}}</span><span>Confirmation</span></a>
                    </li>
                </ul>
                <div class="mt-4">
                    <div class="alert alert-danger alert-icon" v-show="formdata.error">
                        <i class="bx bx-error"></i> <strong>Oops</strong>! {{ formdata.error }}
                    </div>
                </div>
                <div class="tab-content twitter-bs-wizard-tab-content pt-0">
                    <div class="tab-pane prw-tab" v-bind:class="{'active' : form.current == 1}" >

                        <div class="row">
                            <div class="col-lg-7">
                                <div class="row">

                                    <div :class="[show_company_select ? 'col-lg-6' : 'col-lg-6']">
                                        <div class="form-group"><label for="basicpill-date" class="">Date</label><input v-model="formdata.date" id="basicpill-date" type="date" class="form-control" disabled style="cursor: no-drop;background: #eee;" /></div>
                                    </div>

                                    <div v-show="show_company_select" class="col-lg-6">
                                        <div class="form-group"><label for="basicpill-pono" class="">Company:</label><select class="company-id"></select></div>
                                    </div>

                                    <div style="display:none;" :class="[show_company_select ? 'col-lg-4' : 'col-lg-6']">
                                        <div class="form-group"><label for="basicpill-pono" class="">Client PO #</label><input v-model="formdata.request_id" id="basicpill-pono" type="text" class="form-control form-control" /></div>
                                    </div>


                                    <div class="col-lg-6">
                                        <div class="form-group"><label for="basicpill-jolo" class="">Job Location (Nearest City)</label><input v-model="formdata.job_location" id="basicpill-jolo" type="email" class="form-control form-control" /></div>
                                    </div>

                                    <div class="col-lg-6">
                                        <div class="form-group"><label for="basicpill-silo" class="">Work Site Name</label><input v-model="formdata.site_location" id="basicpill-silo" type="email" class="form-control form-control" /></div>
                                    </div>

                                    <div class="col-lg-6">
                                        <div class="form-group"><label for="basicpill-estistart" class="">Estimated Work Start Date</label><input v-model="formdata.estimated_start_date" id="basicpill-estistart" type="date" class="form-control form-control" /></div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group"><label for="basicpill-estiend" class="">Estimated Work End Date</label><input v-model="formdata.estimated_end_date" id="basicpill-estiend" type="date" class="form-control form-control" /></div>
                                    </div>

                                </div>
                            </div>
                            <div class="col-lg-5">
                                <div style="border: 1px solid rgba(0,0,0,.1); border-radius: 4px; padding: 20px;">
                                    <h4 class="card-title mb-4" style="font-size: 13px;">Personnel Required (Type + Number of Personnel)</h4>

                                    <div class="form-group">
                                        <div class="d-flex align-items-center">
                                            <input @click="checkboxToggle('laborers', 'show_laborerInput');" v-model="laborersCheckbox" type="checkbox" class="mr-2" id="show_laborerInput" />
                                            <label for="show_laborerInput" class="mb-0 mr-2">Laborers</label>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="d-flex align-items-center">
                                            <input @click="checkboxToggle('operators', 'show_operatorInput');" v-model="operatorsCheckbox" type="checkbox" class="mr-2" id="show_operatorInput" />
                                            <label for="show_operatorInput" class="mb-0 mr-2">Operators</label>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="d-flex align-items-center">
                                            <input @click="checkboxToggle('supervisors', 'show_supervisorInput');" v-model="supervisorsCheckbox" type="checkbox" class="mr-2" id="show_supervisorInput" />
                                            <label for="show_supervisorInput" class="mb-0 mr-2">Supervisors</label>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="d-flex align-items-center">
                                            <input @click="checkboxToggle('other_personnel', 'show_persotherInput');" v-model="otherPersonnelsCheckbox" id="show_persotherInput" type="checkbox" class="mr-2" />
                                            <label for="show_persotherInput" class="mb-0 mr-2">Other</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="tab-pane prw-tab" v-bind:class="{'active' : form.current == (index + 2)}" v-for="(sub,index) in form.subs" :key="'form-sub-' + index">
                        <PersonnelForm :ref="'personnel'+sub.type" :properties="{ personnel: sub.personnel, type: sub.type }" v-on:done="onPersonnelFormDone" :key="'pf-' + index + '-' + form.key"></PersonnelForm>
                    </div>

                    <div class="tab-pane prw-tab" v-bind:class="{'active' : form.current == (form.subs.length + 2)}">
                        <div v-if="formdata && personnel && form.current == (form.subs.length + 2)" class="confirm-submit">
                            <Single :properties="{ request: formdata, personnel, user }" :key="'edit-single' + formdata.id" />
                        </div>
                    </div>
                    
                    
                    <div class="pr-paginate" v-if="formdata.id != null" style="">
                        <i @click="jump(1)" :class="{'active': form.current == 1}" class="mdi mdi-record"></i>
                        <template v-for="(sub,index) in form.subs" >
                            <i @click="jump(index + 2)" :class="{'active' : form.current == (index + 2)}" :key="'form-sub-paginate-' + index" class="mdi mdi-record"></i>
                        </template>
                        <i @click="jump(form.subs.length + 2)"  :class="{'active': form.current == (form.subs.length + 2) }" class="mdi mdi-record"></i>
                    </div> 



                </div>
                <ul class="pager wizard twitter-bs-wizard-pager-link" style="margin-left: -20px; margin-right: -20px; padding-bottom: 40px; padding-top: 15px; margin-top: 10px; padding-left: 20px; padding-right: 20px; border-top: 1px solid #eff2f7;">
                    <li v-show="form.current > 1 && formdata.id == null" class="previous"><a href="javascript:void(0);" @click="prev()">Previous</a></li>
                    <li v-if="formdata.id != null" class="next"><a href="javascript:void(0);" @click="update()">Save and Leave</a></li>
                    <li v-show="form.current < (form.subs.length + 2) && formdata.id == null" class="next"><a href="javascript:void(0);" @click="next()">Next</a></li>
                    <li class="next">
                        <div v-if="form.current == (form.subs.length + 2)" v-bind:class="{'active' : form.current == (form.subs.length + 2)}" class="tab-pane prw-tab">
                            <button v-if="formdata.id === null" @click="save()" class="btn btn-success">Save</button>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
        </div>
    </div>
</template>



<script>
    import moment from 'moment'
    import PersonnelForm from './PersonnelForm'
    import Single from './Single'

    export default {
        name: 'personnel-requests',
        props: ['properties'],
        data: function () {
            return {
                // only show company select to admin
                show_company_select: false,
                // for checkboxes with text fields
                show_laborerInput: false,
                show_operatorInput: false,
                show_supervisorInput: false,
                show_persotherInput: false,

                laborersCheckbox: false,
                operatorsCheckbox: false,
                supervisorsCheckbox: false,
                otherPersonnelsCheckbox: false,
                formdata: {
                    // personnel request
                    id: null,
                    company: {
                        name:null,
                        email:null,
                        phone:null,
                    },
                    company_id: null,
                    date: '',
                    request_id: '',
                    job_location: '',
                    site_location: '',

                    estimated_start_date : '',
                    estimated_end_date : '',

                    success: null,
                    error: null,
                },
                personnel: {
                    laborers: {},
                    operators: {},
                    supervisors: {},
                    other_personnel: {},
                },
                form: {
                    highest: 1,
                    key: '',
                    current: 1,
                    subs: [],
                    sub_index: 0,
                    sub_current: 0,
                },
                show_accord: false,
            }
        },
        watch: {

        },
        computed: {
            user: function () {
                var scope = this
                return scope.$store.getters.getAuthenticatedUser
            }
        },
        components: {
            PersonnelForm,
            Single,
        },
        filters: {
            fromNow: function (date) {
                return moment(date).fromNow();
            },
            calendar: function (date) {
                return moment(date).calendar();
            },
            MDY: function (date) {
                return moment(date).format('MM/DD/yyyy');
            },
            YMD: function (date) {
                return moment(date).format('YYYY-MM-DD');
            }
        },
        methods: {
            updatePersonnelRequest: function (request) {
                var scope = this
                var key = scope.UNIQUE();

                scope.form = {
                    key: key,
                    current: 1,
                    subs: [],
                    sub_index: 0,
                    sub_current: 0,
                }

                scope.setData(request);
                // scope.OPEN_MODAL('#fake-request')
                scope.show_company_select = false
            },
            onPersonnelFormDone (value) {
                var scope = this
                scope.personnel[value.type] = value
            },
            checkboxToggle: function (data_model, show_input) {
                var scope = this

                // in 'edit': if toggled turn to empty
                if(scope[`${data_model}Checkbox`]) {
                    window.swal.fire({
                        title: 'Are you sure you want to delete this Personnel and all its data?',
                        text: 'You won\'t be able to revert this',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Yes, remove it!',
                        cancelButtonText: 'Cancel'
                    }).then((result) => {
                        if (result.value) {
                            //scope.personnel[data_model].personnel_needed = ''
                            scope[show_input] = false

                            scope.personnel[data_model] =  {}

                            for (var index = 0; index < scope.form.subs.length; index++) {
                                if(scope.form.subs[index].type === data_model) {
                                    scope.form.subs.splice(index, 1)
                                }
                            }

                            return
                        }
                        var checkboxModel = data_model + 'Checkbox'
                        scope[checkboxModel] = true
                    })

                } else{
                    // if 'add'
                    scope[show_input] = !scope[show_input]
                }
            },
            validateBasicDetails: function () {
                var scope = this
                scope.resetValidation()

                if(scope.formdata.job_location === ''){
                    scope.formdata.error = 'Please Enter Job Location'
                    $('#basicpill-jolo').css('border-color', 'red')
                    $('#basicpill-jolo').focus()
                    return false
                }
                if(scope.formdata.site_location === ''){
                    scope.formdata.error = 'Please Enter Work Site Name'
                    $('#basicpill-silo').css('border-color', 'red')
                    $('#basicpill-silo').focus()
                    return false
                }
                if(!scope.formdata.estimated_start_date){
                    scope.formdata.error = 'Please Enter Estimated Work Start Date'
                    $('#basicpill-estistart').css('border-color', 'red')
                    $('#basicpill-estistart').focus()
                    return false
                }
                if(!scope.formdata.estimated_end_date){
                    scope.formdata.error = 'Please Enter Estimated Work End Date'
                    $('#basicpill-estiend').css('border-color', 'red')
                    $('#basicpill-estiend').focus()
                    return false
                }

                return true
            },
            validatePersonnelForm: function () {
                var scope = this
                scope.resetValidation()
                
                var current_sub = scope.form.subs[scope.form.sub_index]
                var data = scope.$refs['personnel'+current_sub.type][0].getPersonnelData()

                if(current_sub.current === 1) {

                    // 1st form on sub
                    if(data.shift_duration == ''){
                        scope.formdata.error = 'Please Enter Shift Duration'
                        $('#basicpill-shiftdu-' + current_sub.type).css('border-color', 'red')
                        $('#basicpill-shiftdu-' + current_sub.type).focus()
                        return false
                    }
                    if(data.scope_of_work == ''){
                        scope.formdata.error = 'Please Enter Scope of Work'
                        $('#basicpill-scope-' + current_sub.type).css('border-color', 'red')
                        $('#basicpill-scope-' + current_sub.type).focus()
                        return false
                    }

                    let counter = 0
                    let hasError = false
                    data.personnel_details.forEach(element => {
                        if (element.job_title == '') {
                            scope.formdata.error = 'Please Enter Job Title'
                            $('#job-title-' + counter).css('border-color', 'red')
                            $('#job-title-' + counter).focus()
                            return hasError = true
                        }
                        if (element.quantity == '') {
                            scope.formdata.error = 'Please Specify How Many Operators'
                            $('#job-no-of-operators-' + counter).css('border-color', 'red')
                            $('#job-no-of-operators-' + counter).focus()
                            return hasError = true
                        }
                        if (element.job_description == '') {
                            scope.formdata.error = 'Please Enter Job Description'
                            $('#job-description-' + counter).css('border-color', 'red')
                            $('#job-description-' + counter).focus()
                            return hasError = true
                        }
                        counter++
                    })
                    if (hasError) {
                        hasError = false
                        return false
                    }
                    
                    if(data.shift_duration == ''){
                        scope.formdata.error = 'Please Enter Shift Duration'
                        $('#basicpill-shiftdu-' + current_sub.type).css('border-color', 'red')
                        $('#basicpill-shiftdu-' + current_sub.type).focus()
                        return false
                    }
                }

                if(current_sub.current === 2) {
                    // 2nd form on sub
                    if(data.work_conditions === ''){
                        scope.formdata.error = 'Please Enter Work Conditions'
                        $('#CustomCheckWorkCondition-' + current_sub.type).css('border-color', 'red')
                        $('#CustomCheckWorkCondition-' + current_sub.type).focus()
                        return false
                    }

                }

                if(current_sub.current === 3) {
                    // 3rd form on sub
                    if(data.drug_and_alcohol_test.mask_fit_requirements === ''){
                        scope.formdata.error = 'Please Enter Mask Fit Requirements'
                        $('#CustomCheckMask-' + current_sub.type).css('border-color', 'red')
                        $('#CustomCheckMask-' + current_sub.type).focus()
                        return false
                    }
                    if(data.drug_and_alcohol_test.can_lift_more_than_sixty_pounds === ''){
                        scope.formdata.error = 'Please Enter Heavy Lifting Required'
                        $('#customRadioLiftingLabel-' + current_sub.type).css('color', 'red')
                        return false
                    }
                }

                if(current_sub.current === 4) {
                    // 4th form on sub
                    if(current_sub.type === 'operators') {
                        if(data.operator_requirement.driver_requirements.length === 0){
                            scope.formdata.error = 'Please Enter Driver License Requirements'
                            $('#labelDriverLicenseRequirements-' + current_sub.type).css('color', 'red')
                            $('#labelDriverLicenseRequirements-' + current_sub.type).focus()
                            return false
                        }
                        if(data.operator_requirement.driver_abstract === ''){
                            scope.formdata.error = 'Please Enter Driver’s Abstract'
                            $('#basicpill-abstract-' + current_sub.type).css('border-color', 'red')
                            $('#basicpill-abstract-' + current_sub.type).focus()
                            return false
                        }
                        if(data.operator_requirement.is_off_road_needed === ''){
                            scope.formdata.error = 'Please Enter is Off-road needed'
                            $('#labelOffRoadNeeded-' + current_sub.type).css('color', 'red')
                            return false
                        }
                        if(data.operator_requirement.is_chain_up_needed === ''){
                            scope.formdata.error = 'Please Enter is Chain-up needed'
                            $('#labelChainupNeeded-' + current_sub.type).css('color', 'red')
                            return false
                        }
                        if(data.operator_requirement.mountain_experience === ''){
                            scope.formdata.error = 'Please Enter is Mountain Experience needed'
                            $('#labelOffMountainExpNeeded-' + current_sub.type).css('color', 'red')
                            return false
                        }
                        if(data.operator_requirement.radio_calling_experience === ''){
                            scope.formdata.error = 'Please Enter is Radio Calling Experience needed'
                            $('#labelRadioCallingNeeded-' + current_sub.type).css('color', 'red')
                            return false
                        }
                        if(data.operator_requirement.dispatch_apps_for_smartphone_required === ''){
                            scope.formdata.error = 'Please Enter is Dispatching Apps for smart phones needed'
                            $('#labelDispatchApps-' + current_sub.type).css('color', 'red')
                            return false
                        }
                        if(data.operator_requirement.transmission_type.length === 0){
                            scope.formdata.error = 'Please Enter is Transmission Type needed'
                            $('#labelTransmissionType-' + current_sub.type).css('color', 'red')
                            return false
                        }
                        if(data.operator_requirement.hours_of_service === ''){
                            scope.formdata.error = 'Please Enter Hours of Service'
                            $('#labelRadioCallingNeeded-' + current_sub.type).css('color', 'red')
                            return false
                        }
                    }
                   
                }

                return true;
            },
            resetValidation: function () {
                var scope = this
                $('input').css('border-color', '#ced4da')
                $('textarea').css('border-color', '#ced4da')
                $('label').css('color', '#495057')
                scope.formdata.error = ''
            },
            next: function () {
                var scope = this

                if (scope.form.current == 1) {
                    var company_id = $('.company-id').val()
                    scope.GET('companies/company/1').then(res => {

                        if(!res.success) {
                            return scope.formdata.error = res.message
                        }

                        scope.formdata.company.name = res.rows[0]['name']
                        scope.formdata.company.email = res.rows[0]['email']
                        scope.formdata.company.phone = res.rows[0]['phone']


                    })

                    if(company_id)
                    {
                        scope.formdata.company_id = company_id
                    }
                    else if(scope.user.type === 'Employer')
                    {
                        
                        console.log('sulooood')
                        console.log(scope.user)
                        scope.formdata.company_id = company_id
                        // scope.formdata.company_id = scope.user.company.id
                    }

                    var valid = scope.validateBasicDetails();
                    if (!valid) {
                        return
                    }

                    scope.addPersonnelFormTabs();
                }

                if (scope.form.subs.length < 1) {
                    scope.formdata.error = 'Please add at least 1 personnel type'
                    return false
                }

                if (scope.form.current > 1 && scope.form.current < scope.form.subs.length + 2) {
                    var current_sub = scope.form.subs[scope.form.sub_index]
                    var valid =  scope.validatePersonnelForm()
                    if (!valid) {
                        return
                    }

                    current_sub.current = (current_sub.current > current_sub.pages) ? current_sub.pages : current_sub.current + 1

                    if (current_sub.current <= current_sub.pages) {

                        scope.$refs['personnel'+current_sub.type][0].next(current_sub.current,current_sub.pages)

                    } else {
                        scope.$refs['personnel'+current_sub.type][0].done()
                        scope.form.current += 1
                        scope.form.sub_index += 1
                        scope.form.highest = (scope.form.current > scope.form.highest) ? scope.form.current : scope.form.highest
                    }

                    return

                }

                scope.form.current += 1
                scope.form.highest = (scope.form.current > scope.form.highest) ? scope.form.current : scope.form.highest


                return
            },
            prev: function () {
                var scope = this

                if (scope.form.current > 1 && scope.form.current < scope.form.subs.length + 2) {
                    var current_sub = scope.form.subs[scope.form.sub_index]

                    if (current_sub.current <= 1 ) {
                        current_sub.current = 1
                        scope.form.current -= 1
                        scope.form.sub_index = (scope.form.sub_index <= 1) ? 0 : scope.form.sub_index - 1
                        console.log(scope.form.sub_index )
                        //scope.form.current -= 1
                        return
                    }

                    current_sub.current -= 1


                    if (current_sub.current <= current_sub.pages) {
                        scope.$refs['personnel'+current_sub.type][0].prev(current_sub.current,current_sub.pages)

                    } else {
                        scope.form.current -= 1
                        scope.form.sub_index = (scope.form.sub_index <= 1) ? 0 : scope.form.sub_index - 1
                    }

                    return
                } else {
                    scope.form.sub_index = (scope.form.sub_index <= 1) ? 0 : scope.form.sub_index - 1
                    scope.form.current -= 1
                }

                return
            },
            jump: function (step) {
                var scope = this

                if (scope.form.subs.length < 1) {
                    alert('Please add at least 1 personnel type')
                    return
                }

                if (step > scope.form.highest) {
                    return
                }

                if (step > 1 && step < scope.form.subs.length + 2) {
                    scope.form.current = step
                    scope.form.sub_index = step  - 2
                    scope.form.sub_current = 0
                } else if (step == 1) {
                    scope.form.current = 1
                    scope.form.sub_index = 0
                    scope.form.sub_current = 0
                } else {
                    scope.form.current = scope.form.subs.length + 2
                    scope.form.sub_index = scope.form.subs.length - 1
                    scope.form.sub_current = 0
                }
            },
            addPersonnelFormTabs: function () {
                var scope = this


                if (scope.laborersCheckbox && scope.form.subs.filter(e => e.title === 'Laborers').length < 1) {
                    scope.form.subs.push({ title: 'Laborers', personnel: scope.personnel.laborers, type: 'laborers', pages: 4, current: 1 });
                }

                if (scope.operatorsCheckbox && scope.form.subs.filter(e => e.title === 'Operators').length < 1) {
                    scope.form.subs.push({ title: 'Operators', personnel: scope.personnel.operators, type: 'operators', pages: 4, current: 1});
                }


                if (scope.supervisorsCheckbox && scope.form.subs.filter(e => e.title === 'Supervisors').length < 1) {
                    scope.form.subs.push({ title: 'Supervisors', personnel: scope.personnel.supervisors, type: 'supervisors', pages: 4, current:1 });
                }

                if (scope.otherPersonnelsCheckbox && scope.form.subs.filter(e => e.title === 'Others').length < 1) {
                    scope.form.subs.push({ title: 'Others', personnel: scope.personnel.other_personnel, type: 'other personnel', pages: 4, current: 1 });
                }
            },
            save: function () {
                var scope = this
                scope.resetValidation()

                var company_id = $('.company-id').val()
                if(company_id)
                {
                    scope.formdata.company_id = company_id
                }
                else if(scope.user.type === 'Employer')
                {
                    scope.formdata.company_id = scope.user.company.id
                }

                scope.formdata.personnel = scope.personnel
                scope.POST('personnel/request', scope.formdata).then(res => {
                    if(res.success) {
                        window.swal.fire({
                            position: 'center',
                            icon: 'success',
                            title: 'Successfully Created',
                            showConfirmButton: false,
                            timer: 1500
                        }).then(() => {
                            // toastr["success"](res.message)
                            setTimeout(function(){ 
                                scope.$router.push({path: '/personnels/requests'})
                            }, 1500)
                        })
                    }else{
                        toastr["error"](res.message)
                        return
                    }
                })

            },

            update: function () {
                var scope = this

                scope.resetValidation()
                scope.formdata.personnel = scope.personnel

                scope.PUT('personnel/request/' +  scope.formdata.id, scope.formdata).then(res => {
                    if(res.success) {
                        window.swal.fire({
                            position: 'center',
                            icon: 'success',
                            title: 'Successfully Updated',
                            showConfirmButton: false,
                            timer: 1500
                        }).then(() => {
                            //toastr["success"](res.message)
                            setTimeout(function(){ 
                                scope.$router.push({path: '/personnels/requests'})
                            }, 1500)
                        })
                    }else{
                        toastr["error"](res.message)
                        return
                    }


                })
            },
            setData: function (data) {
                var scope = this

                scope.form.highest = 100 // make edit jump from numbers to numbers
                scope.formdata = data
                scope.$set(scope.formdata,'error',null);

                var newOption = new Option(data.company.name, data.company_id, true, true);
                $(".company-id").append(newOption).trigger('change');

                for (let index = 0; index < data.personnel.length; index++) {
                    const personnel = data.personnel[index];

                    if(personnel.type === 'laborers') {
                        scope.laborersCheckbox = true
                        scope.personnel.laborers = personnel
                        scope.addPersonnelFormTabs()
                    }

                    if(personnel.type === 'operators') {
                        scope.operatorsCheckbox = true
                        scope.personnel.operators = personnel
                        scope.addPersonnelFormTabs()
                    }

                    if(personnel.type === 'supervisors') {
                        scope.supervisorsCheckbox = true
                        scope.personnel.supervisors = personnel
                        scope.addPersonnelFormTabs()
                    }

                    if(personnel.type === 'other_personnel') {
                        scope.otherPersonnelsCheckbox = true
                        scope.personnel.other_personnel = personnel
                        scope.addPersonnelFormTabs()
                    }
                }

            },
            resetFormData: function () {
                var scope = this
                
                scope.formdata = {
                    id: null,
                    company_id: null,
                    date: moment().format("YYYY-MM-DD"),
                    request_id: '',
                    job_location: '',
                    site_location: '',

                    success: null,
                    error: null,
                },

                scope.personnel = {
                    laborers: {},
                    operators: {},
                    supervisors: {},
                    other_personnel: {},
                },

                scope.form = {
                    current: 1,
                    subs: [],
                    sub_index: 0,
                    sub_current: 0,
                }

                scope.laborersCheckbox = false
                scope.operatorsCheckbox = false
                scope.supervisorsCheckbox = false
                scope.otherPersonnelsCheckbox = false

                scope.show_laborerInput = false
                scope.show_operatorInput = false
                scope.show_supervisorInput = false
                scope.show_persotherInput = false
            },

            toggle_company_select: function () {
                var scope = this

                if(scope.user.type === 'Admin') {
                    scope.show_company_select = true
                }
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
            },
            toggleAccordionById: function(id) {
                var scope = this

                if(scope.show_accord == false)
                {
                    
                    $(`#accordion #${id}.collapse`).addClass('show')
                    return scope.show_accord = true
                }

                $(`#accordion  #${id}.collapse`).removeClass('show')
                return scope.show_accord = false
            },


            getPersonnelRequest: function (personnel_request_id) {
                var scope = this
                scope.requests = [];
                scope.GET('personnel/request/' + personnel_request_id).then(res => {
                    if(!res.success) {
                        scope.$router.push({path: '/personnels/requests'})
                    }

                    scope.setData(res.data)
                })
            },
        },
        mounted() {
            var scope = this

           // scope.getList()
            scope.formdata.date = moment().format("YYYY-MM-DD")
            if (scope.$route.params.id && scope.$route.params.id !== 'create') {
                scope.getPersonnelRequest(scope.$route.params.id);
            }
        
            $(`#accordion .card:nth-child(1) .collapse`).addClass('show')

            /*
            if (scope.$route.query.create && scope.$route.query.create == 'yes') {
                scope.OPEN_MODAL('#modal-request');
            }

            if (scope.$route.query.refid) {
                var id = scope.$route.query.refid
                setTimeout(function(){
                    $(document).find('.request-view-' + id).trigger('click');
                },300);
                
            }
            */

            // only Admin can search companies
            if(scope.user && scope.user.type === 'Admin') {
                scope.show_company_select = true

                $('.company-id').select2({
                    ajax: {
                        url: '/api/companies/search?type=Employer&text=company',
                        dataType: 'json',
                        delay: 300,
                        processResults: function (data) {
                            return {
                                results: data.rows
                            };
                        }
                    }
                })

                $('.recipients-list').select2({
                    ajax: {
                        url: '/api/companies/search',
                        dataType: 'json',
                        delay: 300,
                        processResults: function (data) {
                            return {
                                results: data.rows
                            };
                        }
                    }
                })
            }
        }
    }
</script>
<style scoped>
    .pr-paginate { margin-top:30px; text-align:center; }
    .pr-paginate i { font-size:20px; color:#ccc; cursor:pointer; }
    .pr-paginate i.active { color:#f58220;  }
    .pr-paginate i:hover { color:#333;  }

    ul { margin-bottom: .6rem; }
    .card .collapse, .card .collapse.show { transition: .5s; }
    /*.card-header, .card-body { border: 1px solid #ddd; }*/
    .card-header { cursor: pointer; }
    .card-body { border-top: 0; }
    .confirm-submit span,
    .confirm-submit strong { display: block; }
    .confirm-submit strong { font-size: 14px; }
    .details { border: 1px solid rgba(0,0,0,.1); padding: 10px; border-radius: 6px; }
    .step-number { cursor: pointer; }
    table th, label { white-space: nowrap; }

    #snackbar {
        visibility: hidden;
        min-width: 250px;
        margin-left: -125px;
        background-color: var(--success);
        border: 2px solid #333;
        color: #fff;
        text-align: center;
        border-radius: 4px;
        padding: 10px;
        position: fixed;
        z-index: 1;
        left: 50%;
        bottom: 30px;
        font-size: 17px;
    }

    #snackbar.sb-error {background-color: var(--danger);}

    #snackbar.show {
        visibility: visible;
        -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
        animation: fadein 0.5s, fadeout 0.5s 2.5s;
    }

    @-webkit-keyframes fadein {
        from {bottom: 0; opacity: 0;}
        to {bottom: 30px; opacity: 1;}
    }

    @keyframes fadein {
        from {bottom: 0; opacity: 0;}
        to {bottom: 30px; opacity: 1;}
    }

    @-webkit-keyframes fadeout {
        from {bottom: 30px; opacity: 1;}
        to {bottom: 0; opacity: 0;}
    }

    @keyframes fadeout {
        from {bottom: 30px; opacity: 1;}
        to {bottom: 0; opacity: 0;}
    }

    [id*="card-"] {
    display: none;
    }

    .bxs-check-circle {
        font-size: 17px;
        color: var(--primary);
    }

    .grey-container {
        border: 1px solid #ddd; border-radius: 4px; padding: 10px 12px; margin-bottom: 20px;
    }

    .badge.status {  font-size: 11.5px; }
</style>