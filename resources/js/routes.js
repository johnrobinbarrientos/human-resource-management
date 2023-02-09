import Vue from 'vue'
import VueRouter from 'vue-router'

import Auth from './views/public/Auth'
import Register from './views/public/Register'
import Verification from './views/public/Verification'
import EmailChangeVerification from './views/public/EmailChangeVerification'
import Confirmation from './views/public/Confirmation'
import ConfirmationRequired from './views/public/ConfirmationRequired'
import ForgotPassword from './views/public/ForgotPassword'
import Logout from './views/public/Logout'
// import Resume from './views/public/Resume'

import Resume from './views/protected/resume/Details'
import Dashboard from './views/protected/Dashboard'
import Profile from './views/protected/Profile'

import UserAdmins from './views/protected/users/Admins'
import UserEmployers from './views/protected/users/Employers'
import UserCandidates from './views/protected/users/Candidates'

import JobList from './views/protected/jobs/List'
import JobCategories from './views/protected/jobs/Categories'
import JobSubcategories from './views/protected/jobs/Subcategories'
import CoreCompetencies from './views/protected/jobs/CoreCompetencies'
import JobMatches from './views/protected/jobs/Matches'
import JobApplicants from './views/protected/jobs/Applicants'
import JobRecommendations from './views/protected/jobs/recommendations/Main'
import JobRecommendationResponse from './views/protected/jobs/recommendations/RecommendationResponse'
import JobCandidateRecommendationResponse from './views/protected/jobs/CandidateRecommendationResponse'
import JobForm from './views/protected/jobs/Form'
import JobDetails from './views/protected/jobs/Details'


import PersonnelList from './views/protected/personnels/List'
import PersonnelRequestForm from './views/protected/personnels/Form'
import PersonnelRequests from './views/protected/personnels/Requests'

import MessageCenterList from './views/protected/message-center/List'
import CompanyList from './views/protected/companies/List'

import Inbox from './views/protected/messages/Inbox'
import ReadMessage from './views/protected/messages/ReadMessage'

Vue.use(VueRouter)

function checkAuth (to, from, next) {
    // check if route is protected
    if (to.meta.protected) {
      var token = localStorage.getItem(window.TOKEN_KEY)
      if (token && token !== null && token !== '' ) {
        next() // allow to enter route
      } else {
        next('/auth?redirect=' + window.location.href) // go to '/auth';
      }
    } else {
      next()
    }
}

function checkGuess (to, from, next) {
    // check if route is protected
    var token = localStorage.getItem(window.TOKEN_KEY)
    if (token && token !== null && token !== '' ) {
    next('/')// allow to enter route
    } else {
    next() // go to '/auth';
    }
  
}

export default new VueRouter({
    mode: 'history',
    routes: [
        {
            path: '/auth',
            name: 'auth',
            component: Auth,
            beforeEnter: checkGuess,
            meta: { protected: false }
        },
        {
            path: '/confirmation',
            name: 'confirmation',
            component: Confirmation,
            meta: { protected: false }
        },
        {
            path: '/confirmation-required',
            name: 'confirmation-required',
            component: ConfirmationRequired,
            meta: { protected: false }
        },
        {
            path: '/logout',
            name: 'logout',
            component: Logout,
            meta: { protected: false }
        },
        {
            path: '/register',
            name: 'register',
            component: Register,
            beforeEnter: checkAuth,
            meta: { protected: false }
        },
        {
            path: '/forgot-password',
            name: 'forgot-password',
            component: ForgotPassword,
            beforeEnter: checkAuth,
            meta: { protected: false }
        },
        {
            path: '/verify/:token',
            name: 'verification',
            component: Verification,
            meta: { protected: false }
        },
        {
            path: '/email-change-verify/:token',
            name: 'email-change-verification',
            component: EmailChangeVerification,
            meta: { protected: false }
        },
        {
            path: '/resume',
            name: 'resume',
            beforeEnter: checkAuth,
            component: Resume,
            meta: { protected: true }
        },
        /**{
            path: '/resume/:username',
            name: 'resume-user',
            beforeEnter: checkAuth,
            component: Resume,
            meta: { protected: true }
        }**/,
        {
            path: '/resume/:username',
            name: 'resume-details',
            beforeEnter: checkAuth,
            component: Resume,
            meta: { protected: true }
        },
        {
            path: '/',
            name: 'dashboard',
            component: Dashboard,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },
        {
            path: '/dashboard',
            name: 'dashboard',
            component: Dashboard,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },
        {
            path: '/profile',
            name: 'profile',
            component: Profile,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },
        {
            path: '/inbox',
            name: 'inbox',
            component: Inbox,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },
        {
            path: '/read-message',
            name: 'read-message',
            component: ReadMessage,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },
        {
            path: '/administrators',
            name: 'administrators',
            component: UserAdmins,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },
        {
            path: '/employers',
            name: 'employers',
            component: UserEmployers,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },
        {
            path: '/candidates',
            name: 'candidates',
            component: UserCandidates,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },
        {
            path: '/jobs/categories',
            name: 'jobs-categories',
            component: JobCategories,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },
        {
            path: '/jobs/subcategories',
            name: 'jobs-subcategories',
            component: JobSubcategories,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },
        {
            path: '/jobs/core-competencies',
            name: 'job-core-competencies',
            component: CoreCompetencies,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },
        {
            path: '/jobs/posts',
            name: 'jobs-posts',
            component: JobList,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },
        {
            path: '/jobs/:jobPostID/view/',
            name: 'jobs-posts-details',
            component: JobDetails,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },
        {
            path: '/personnels',
            name: 'personnel-list',
            component: PersonnelList,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },
        {
            path: '/personnels/requests',
            name: 'personnel-requests-list',
            component: PersonnelRequests,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },
        {
            path: '/personnels/requests/:id',
            name: 'personnel-requests-form',
            component: PersonnelRequestForm,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },
        {
            path: '/jobs/create',
            name: 'jobs-form',
            component: JobForm,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },
        {
            path: '/jobs/:jobPostID/edit',
            name: 'jobs-form-edit',
            component: JobForm,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },
        {
            path: '/jobs/:jobPostID/matches',
            name: 'jobs-matches',
            component: JobMatches,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },
        {
            path: '/jobs/:jobPostID/applicants',
            name: 'jobs-applicants',
            component: JobApplicants,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },
        {
            path: '/jobs/recommendations',
            name: 'jobs-recommendations',
            component: JobRecommendations,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },
        {
            path: '/jobs/:jobPostID/recommendations',
            name: 'job-recommendations',
            component: JobRecommendations,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },
        {
            path: '/jobs/:jobPostID/recommendations/:token/:action',
            name: 'jobs-recommendation-response',
            component: JobRecommendationResponse,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },
        {
            path: '/jobs/:jobPostID/candidate-recommendations/:token/:action',
            name: 'jobs-candidate-recommendation-response',
            component: JobCandidateRecommendationResponse,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },
        {
            path: '/companies',
            name: 'companies',
            component: CompanyList,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },
        {
            path: '/message-center',
            name: 'message-center',
            component: MessageCenterList,
            beforeEnter: checkAuth,
            meta: { protected: true }
        },

    ],
});