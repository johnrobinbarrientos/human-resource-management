<template>
  <div v-if="properties && properties.formdata && properties.personnel" >
      <div class="row">
          <div class="col-lg-12">
              <div class="card">
                  <div class="card-header">
                      <div class="row">
                          <div class="col-lg-4">
                              <strong>Basic Detil:</strong>
                              <span>Request ID: {{ properties.formdata.request_id }}</span>
                              <span>Date: {{ properties.formdata.date }}</span>
                              <span>Job Location: {{ properties.formdata.job_location }}</span>
                              <span>Site Location: {{ properties.formdata.site_location }}</span>
                          </div>
                          <div class="col-lg-4">
                              <template v-if="properties.formdata.company">
                                  <strong>Company Details:</strong>
                                  <span>Company Name: {{ properties.formdata.company.name }}</span>
                                  <span>Email: {{ properties.formdata.company.email }}</span>
                                  <span>Contact #: {{ properties.formdata.company.phone }}</span>
                              </template>
                          </div>

                          <div class="col-lg-4">
                              <strong>Personnel Needed:</strong>
                                  <span v-if="properties.personnel.laborers.type" class="text-capitalize">{{ properties.personnel.laborers.type }}: {{ properties.personnel.laborers.personnel_needed }}</span>
                                  <span v-if="properties.personnel.operators.type" class="text-capitalize">{{ properties.personnel.operators.type }}: {{ properties.properties.personnel.operators.personnel_needed }}</span>
                                  <span v-if="properties.personnel.other_personnel.type" class="text-capitalize">{{ properties.personnel.other_personnel.type }}: {{ properties.personnel.other_personnel.personnel_needed }}</span>
                                  <span v-if="properties.personnel.supervisors.type" class="text-capitalize">{{ properties.personnel.supervisors.type }}: {{ properties.personnel.supervisors.personnel_needed }}</span>
                          </div>
                      </div>
                  </div>
              </div>
          </div>
          <div class="col-lg-12">
              <div id="accordion">
                  <div @click="toggleAccordion( 1)" class="mb-1 card">
                      <div id="headingOne" class="card-header" style="padding: .5rem 1.25rem">
                          <div class="d-flex justify-content-between align-items-center">
                              <strong class="m-0 font-14"><span class="text-capitalize">{{ properties.personnel.laborers.type }}</span></strong>
                              <i class="las la-plus-circle" style="font-size: 29px"></i>
                          </div>
                      </div>
                      <div class="collapse" style="">
                          <div class="card">
                              <div class="card-body">
                                  <div class="row">
                                      <div class="col-lg-4">
                                          <strong>Work Shift Details</strong>
                                          <span>Personnel Needed: {{ properties.personnel.laborers.personnel_needed }}</span>
                                          <span>Shift Duration (Hours per day/per shift): {{ properties.personnel.laborers.shift_duration }}</span>
                                          <span>Estimated Work Start Date: {{ properties.formdata.estimated_start_date }}</span>
                                          <span>Estimated Work End Date: {{ properties.formdata.estimated_end_date }}</span>
                                          <span>Percentage of people on day shift: {{ properties.personnel.laborers.percentage_of_people_on_day_shift }}</span>
                                          <span>Scope of Work: {{ properties.personnel.laborers.scope_of_work }}</span><br>

                                          <strong>Tickets Required</strong>
                                          <span v-if="properties.personnel.laborers.first_aid">First Aid: {{ properties.personnel.laborers.first_aid }}</span>
                                          <span v-if="properties.personnel.laborers.H2S_alive">H2S Alive: {{ properties.personnel.laborers.H2S_alive }}</span>
                                          <span v-if="properties.personnel.laborers.CSTS">CSTS: {{ properties.personnel.laborers.CSTS }}</span>
                                          <span v-if="properties.personnel.laborers.confined_space">Confined Space: {{ properties.personnel.laborers.confined_space }}</span>
                                          <span v-if="properties.personnel.laborers.ground_disturbance">Ground Disturbance: {{ properties.personnel.laborers.ground_disturbance }}</span>
                                          <span v-if="properties.personnel.laborers.fall_arrest">Fall Arrest: {{ properties.personnel.laborers.fall_arrest }}</span>
                                          <span v-if="properties.personnel.laborers.CSO">CSO (BSO/eGSO/PST): {{ properties.personnel.laborers.CSO }}</span>
                                          <span v-if="properties.personnel.laborers.other_ticket">Other: {{ properties.personnel.laborers.other_ticket }}</span><br>

                                          <strong>Hours of Orientation</strong>
                                          <span>On Site: {{ properties.personnel.laborers.hours_of_orientation_on_site }} hour(s)</span>
                                          <span class="d-flex">
                                            <span class="mr-1">Online:</span>
                                            <span v-if="properties.personnel.laborers.hours_of_orientation_online">{{ properties.personnel.laborers.hours_of_orientation_online }} hour(s)</span>
                                            <span v-else>N/A</span>
                                        </span>
                                      </div> 

                                      <div class="col-lg-4">

                                          <strong>Additional Details/Requirements</strong>
                                          <span>Accomodation: {{ properties.personnel.laborers.accomodation }}</span>
                                          <span>Work Conditions: {{ properties.personnel.laborers.work_conditions }}</span>
                                          <span>Specialized PPE required?: {{ properties.personnel.laborers.specialized_PPE }}</span>
                                          <br>

                                          <strong>Drug and Alcohol Test</strong>
                                          <span>Test: {{ properties.personnel.laborers.test }}</span>
                                          <span>Is Cannabis Swap Acceptable: {{ properties.personnel.laborers.is_cannabis_swap_acceptable }}</span>
                                          <span>How Recent?: {{ properties.personnel.laborers.how_recent }}</span>
                                          <span>Mask Fit Requirements: {{ properties.personnel.laborers.mask_fit_requirements }}</span>
                                          <span v-if="properties.personnel.laborers.can_lift_more_than_sixty_pounds == 1">Heavy Lifting Required (More than 60 lbs): Yes</span>
                                          <span v-else>Heavy Lifting Required (More than 60 lbs): No</span>

                                      </div>

                                  </div>
                                  <div class="row mt-4">
                                      <div class="col-lg-12">
                                          <div class="details">
                                              <strong class="mb-2">Additional Pre Employment Requirements:</strong>
                                              {{ properties.personnel.laborers.pre_employments }}
                                          </div>
                                      </div>
                                  </div>
                              </div>
                          </div>
                      </div>
                  </div>

                  <div  @click="toggleAccordion(2)" class="mb-1 card">
                      <div id="headingOnechanged" class="card-header" style="padding: .5rem 1.25rem">
                          <div class="d-flex justify-content-between align-items-center">
                              <strong class="m-0 font-14"><span class="text-capitalize">Operators</span></strong>
                              <i class="las la-plus-circle" style="font-size: 29px"></i>
                          </div>
                      </div>
                      <div class="collapse" style="">
                          <div class="card">
                              <div class="card-body">
                                  <div class="row">
                                      <div class="col-lg-4">
                                          <strong>Work Shift Details</strong>
                                          <span>Personnel Needed: {{ properties.personnel.operators.personnel_needed }}</span>
                                          <span>Estimated Work Start Date: {{ properties.formdata.estimated_start_date }}</span>
                                          <span>Estimated Work End Date: {{ properties.formdata.estimated_end_date }}</span>
                                          <span>Estimated Work End Date: {{ properties.personnel.operators.estimated_end_date }}</span>
                                          <span>Percentage of people on day shift: {{ properties.personnel.operators.percentage_of_people_on_day_shift }}</span>
                                          <span>Scope of Work: {{ properties.personnel.operators.scope_of_work }}</span><br>

                                          <strong>Tickets Required</strong>
                                          <span v-if="properties.personnel.operators.first_aid">First Aid: {{ properties.personnel.operators.first_aid }}</span>
                                          <span v-if="properties.personnel.operators.H2S_alive">H2S Alive: {{ properties.personnel.operators.H2S_alive }}</span>
                                          <span v-if="properties.personnel.operators.CSTS">CSTS: {{ properties.personnel.operators.CSTS }}</span>
                                          <span v-if="properties.personnel.operators.confined_space">Confined Space: {{ properties.personnel.operators.confined_space }}</span>
                                          <span v-if="properties.personnel.operators.ground_disturbance">Ground Disturbance: {{ properties.personnel.operators.ground_disturbance }}</span>
                                          <span v-if="properties.personnel.operators.fall_arrest">Fall Arrest: {{ properties.personnel.operators.fall_arrest }}</span>
                                          <span v-if="properties.personnel.operators.CSO">CSO (BSO/eGSO/PST): {{ properties.personnel.operators.CSO }}</span>
                                          <span v-if="properties.personnel.operators.other_ticket">Other: {{ properties.personnel.operators.other_ticket }}</span><br>

                                          <strong>Hours of Orientation</strong>
                                          <span>On Site: {{ properties.personnel.operators.hours_of_orientation_on_site }} hour(s)</span>
                                          <span class="d-flex">
                                            <span class="mr-1">Online:</span>
                                            <span v-if="properties.personnel.operators.hours_of_orientation_online">{{ properties.personnel.operators.hours_of_orientation_online }} hour(s)</span>
                                            <span v-else>N/A</span>
                                        </span>
                                      </div>

                                      <div class="col-lg-4">

                                          <strong>Additional Details/Requirements</strong>
                                          <span>Accomodation: {{ properties.personnel.operators.accomodation }}</span>
                                          <span>Work Conditions: {{ properties.personnel.operators.work_conditions }}</span>
                                          <span>Specialized PPE required?: {{ properties.personnel.operators.specialized_PPE }}</span>
                                          <br>

                                          <strong>Drug and Alcohol Test</strong>
                                          <span>Test: {{ properties.personnel.operators.test }}</span>
                                          <span>Is Cannabis Swap Acceptable: {{ properties.personnel.operators.is_cannabis_swap_acceptable }}</span>
                                          <span>How Recent?: {{ properties.personnel.operators.how_recent }}</span>
                                          <span>Mask Fit Requirements: {{ properties.personnel.operators.mask_fit_requirements }}</span>
                                          <span v-if="properties.personnel.operators.can_lift_more_than_sixty_pounds == 1">Heavy Lifting Required (More than 60 lbs): Yes</span>
                                          <span v-else>Heavy Lifting Required (More than 60 lbs): No</span>

                                      </div>
                                      <div  class="col-lg-4">
                                          <strong>Requirements, Experiences etc.</strong>
                                          <span>Driver Requirements: </span>
                                          <ul class="pl-4">
                                              <!--                                              <li v-for="(driver_requirement, index) in JSON.parse(properties.personnel.operators.driver_requirements)" :key="index">{{ driver_requirement }}</li>-->
                                          </ul>
                                          <span>Transmission Type:</span>
                                          <ul class="pl-4">
                                              <!--                                              <li v-for="(type, index) in JSON.parse(properties.personnel.operators.transmission_type)" :key="index">{{ type }}</li>-->
                                          </ul>
                                          <span>Driver’s Abstract: {{ properties.personnel.operators.driver_abstract }}</span>
                                          <span>The number of Demerit Points Acceptable: {{ properties.personnel.operators.demerit_points_acceptable }}</span>
                                          <span>License Class: {{ properties.personnel.operators.license_class }}</span>

                                          <span v-if="properties.personnel.operators.is_off_road_needed == '1'">Off-road needed: Yes</span>
                                          <span v-else>Off-road needed: No</span>

                                          <span v-if="properties.personnel.operators.is_chain_up_needed == '1'">Chain-up needed: Yes</span>
                                          <span v-else>Chain-up needed: No</span>

                                          <span v-if="properties.personnel.operators.mountain_experience == '1'">Mountain experience: Yes</span>
                                          <span v-else>Mountain experience: No</span>

                                          <span v-if="properties.personnel.operators.radio_calling_experience == '1'">Radio Calling Experience: Yes</span>
                                          <span v-else>Radio Calling Experience: No</span>

                                          <span v-if="properties.personnel.operators.dispatch_apps_for_smartphone_required == '1'">Dispatch Apps for smart phone required: Yes</span>
                                          <span v-else>Dispatch Apps for smart phone required: No</span>
                                          <span>Hours of Service: {{ properties.personnel.operators.hours_of_service }}</span>

                                      </div>
                                  </div>
                                  <div class="row mt-4">
                                      <div class="col-lg-12">
                                          <div class="details">
                                              <strong class="mb-2">Additional Pre Employment Requirements:</strong>
                                              {{ properties.personnel.operators.pre_employments }}
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
    import moment from 'moment'

    export default {

        name: 'confirmation-request',
        props: ['properties'],
        data: function () {
            return {
                request: {},
                show_accord: false
            }
        },
        methods: {
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
            scope.request = scope.properties ? scope.properties : {}
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
</style>
