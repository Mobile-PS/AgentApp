import 'package:get/get.dart';

import 'LangConstants.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          LangConstants.ac_ag_login_str_lg: 'Login',
          LangConstants.ac_ag_login_usnm: 'Username',
          LangConstants.app_name: 'Afritek Agent',
          LangConstants.ac_ag_dash_bk_tic: 'Book Ticket',
          LangConstants.ac_ag_dash_resrv: 'Manifest',
          LangConstants.ac_ag_dash_tic_prt: 'Print Ticket',
          LangConstants.ac_ag_dash_cancel_tic: 'Cancel Ticket',
          LangConstants.ac_ag_dash_logout: 'Logout',
          LangConstants.kin_title: 'Next',
          LangConstants.ac_bs_lyt_no_bus: 'No Bus available',
          LangConstants.str_seat: 'Seat',
          LangConstants.ac_sr_bs_act_name: 'Search Bus',
          LangConstants.ac_sr_bs_search: 'Search',
          LangConstants.ac_sr_bs_from: 'From',
          LangConstants.ac_sr_bs_to: 'To',
          LangConstants.ac_sr_bs_all: 'All',
          LangConstants.ac_tic_pay_dt: 'Date',
          LangConstants.ac_sr_bs_etr_bus: 'Select Bus',
          LangConstants.ac_sr_bs_sel_bs_ty: 'Select Bus Type',
          LangConstants.ac_tic_print_tic_enq: 'ENQUIRIES:',
          LangConstants.ac_tic_print_tic_no: 'TICKET No:',
          LangConstants.ac_tic_print_is: ' ISSUED:',
          LangConstants.ac_tic_print_trp: ' TRIP:',
          LangConstants.ac_tic_print_pk: ' Pick Point:',
          LangConstants.ac_tic_print_dr: ' Drop Point:',
          LangConstants.ac_tic_print_bs_cls: ' CLASS:',
          LangConstants.ac_tic_str_tic_id: ' TICKET ID:',
          LangConstants.ac_tic_print_ps: ' PASSENGER:',
          LangConstants.ac_tic_print_ps_ph: ' PASSENGER PHONE:',
          LangConstants.ac_tic_print_st_no: ' SEAT(S) No:',
          LangConstants.ac_tic_print_st_fr: ' SEAT FARE:',
          LangConstants.ac_tic_print_tr_dt: ' TRAVEL DATE:',
          LangConstants.ac_tic_print_dep: ' DEPARTURE:',
          LangConstants.ac_tic_print_repo: ' REPORTING:',
          LangConstants.ac_tic_print_iss: ' ISSUED BY:',
          LangConstants.ac_bs_lyt_cancel: ' Cancel:',
          LangConstants.ac_ag_dash_c_pwd: ' Change Password:',
          LangConstants.ac_agpr_nw: ' New Password:',
          LangConstants.ac_agpr_nw_cfm: 'Confirm  New Password:',
          LangConstants.ac_agpr_pwd_ntm: 'Password does not match..',
          LangConstants.pwd_change_success: 'Password changed successfully',
          LangConstants.ac_ag_dash_settings: 'Select Language',
          LangConstants.ac_bs_lyt_fare_tzs: 'Fare TZS.',
          LangConstants.ac_sel_lang_eng: 'English',
          LangConstants.ac_sel_lang_swa: 'Swahili',
          LangConstants.ac_ag_login_pwd: 'Password',
          LangConstants.ac_ag_login_fg_pwd: 'Forgot password?',
          LangConstants.ac_rsv_li_manifst: '**** MANIFESTI ****',
          LangConstants.nav_header_title: 'AfriTek',
          LangConstants.ac_rsv_li_jr_dt: 'Travel Date',
          LangConstants.phone: 'Agent Phone',
          LangConstants.ac_cncl_tic_adp_nm: 'Name :',
          LangConstants.ac_rsv_li_adp_dr: 'Drop  :',
          LangConstants.ac_ag_bs_lis_fare: 'Fare  :',
          LangConstants.ac_tic_print: 'Print  :',
          LangConstants.ac_tic_pay_submit: 'SEND',
          LangConstants.ac_rsv_li_rt: 'Route',
          LangConstants.str_male: 'Male',
          LangConstants.ac_ag_dash_profile: 'Profile',
          LangConstants.ag_cg_pwd: 'Change Password',
          LangConstants.str_female: 'Female',
          LangConstants.ac_sv_ps_det_lst_name: 'Last Name',
          LangConstants.ac_sv_ps_det_mobl_no: 'Mobile No',
          LangConstants.kin_mobile: 'Kin Mobile',
          LangConstants.kin_name: 'Kin Name',
          LangConstants.ac_sv_ps_det_vtr_card_1: 'Voter',
          LangConstants.ac_sv_ps_det_vtr_card_2: 'Card',
          LangConstants.ac_sv_ps_det_passport_1: 'Passport',
          LangConstants.ac_sv_ps_det_other_id_2: 'ID',
          LangConstants.ac_tic_pay_eml: 'Email',
          LangConstants.ac_sv_ps_det_other_id_1: 'Other',
          LangConstants.ac_sv_ps_det_drv_lic_1: 'Driving',
          LangConstants.ac_sv_ps_det_drv_lic_2: 'Licence',
          LangConstants.ac_tic_acbar_title: 'Print Ticket',
          LangConstants.diptech: 'AfriTek',
        },
        'hi_IN': {
          LangConstants.ac_ag_login_str_lg: 'INGIA',
          LangConstants.ac_ag_login_usnm: 'Jina la Mtumiaji',
          LangConstants.app_name: 'Afritek Wakala',
          LangConstants.ac_ag_dash_bk_tic: 'Kata Tiketi',
          LangConstants.ac_ag_dash_resrv: 'Zilizohifadhiwa',
          LangConstants.ac_ag_dash_tic_prt: 'Printi Tiketi',
          LangConstants.ac_ag_dash_cancel_tic: 'Futa Tiketi',
          LangConstants.ac_ag_dash_logout: 'Toka',
          LangConstants.kin_title: 'Taarifa za Ndugu wa Karibu',
          LangConstants.ac_bs_lyt_no_bus: 'Hakuna Basi linalopatikana',
          LangConstants.str_seat: 'str_seat',
          LangConstants.ac_sr_bs_act_name: 'Tafuta Basi',
          LangConstants.ac_sr_bs_search: 'TUMA',
          LangConstants.ac_sr_bs_from: 'Kutoka',
          LangConstants.ac_sr_bs_to: 'Kwenda',
          LangConstants.ac_sr_bs_all: 'Yote',
          LangConstants.ac_tic_pay_dt: 'Tarehe',
          LangConstants.ac_sr_bs_etr_bus: 'Ingiza Jina la Basi(Sio lazima)',
          LangConstants.ac_sr_bs_sel_bs_ty: 'Chagua Daraja la Basi',
          LangConstants.ac_tic_print_tic_enq: 'MAULIZO:',
          LangConstants.ac_tic_print_tic_no: 'No. ya TIKETI:',
          LangConstants.ac_tic_print_is: 'IMETOLEWA:',
          LangConstants.ac_tic_print_trp: 'SAFARI:',
          LangConstants.ac_tic_print_pk: 'Kupandia:',
          LangConstants.ac_tic_print_dr: 'Kushukia:',
          LangConstants.ac_tic_print_bs_cls: 'ac_tic_print_bs_cls:',
          LangConstants.ac_tic_str_tic_id: 'ac_tic_str_tic_id:',
          LangConstants.ac_tic_str_tic_id: 'ABIRIA:',
          LangConstants.ac_tic_print_ps_ph: 'SIMU YA ABIRIA:',
          LangConstants.ac_tic_print_st_no: 'NAMBA YA KITI:',
          LangConstants.ac_tic_print_st_fr: 'NAULI KWA KITI:',
          LangConstants.ac_tic_print_tr_dt: 'TAREHE YA SAFARI:',
          LangConstants.ac_tic_print_dep: 'KUONDOKA:',
          LangConstants.ac_tic_print_repo: 'KURIPOTI:',
          LangConstants.ac_tic_print_iss: 'IMETOLEWA NA:',
          LangConstants.ac_bs_lyt_cancel: 'Batilisha:',
          LangConstants.ac_ag_dash_c_pwd: 'Badili Nywila:',
          LangConstants.ac_agpr_nw: 'Nywila Mpya:',
          LangConstants.ac_agpr_nw_cfm: 'Thibitisha Nywila Mpya!',
          LangConstants.ac_agpr_pwd_ntm: 'Nywila Haiendani..',
          LangConstants.pwd_change_success: 'pwd_change_success',
          LangConstants.ac_ag_dash_settings: 'Chagua Lugha',
          LangConstants.ac_bs_lyt_fare_tzs: 'Nauli TZS.',
          LangConstants.ac_sel_lang_eng: 'English',
          LangConstants.ac_sel_lang_swa: 'Swahili',
          LangConstants.ac_ag_login_pwd: 'Nywila',
          LangConstants.ac_ag_login_fg_pwd: 'Umesahau Nywila?',
          LangConstants.ac_rsv_li_manifst: '**** MANIFESTI ****',
          LangConstants.nav_header_title: 'Afritek Wakala',
          LangConstants.ac_rsv_li_jr_dt: 'Tarehe ya Safari',
          LangConstants.phone: 'Simu',
          LangConstants.ac_cncl_tic_adp_nm: 'Jina :',
          LangConstants.ac_rsv_li_adp_dr: 'Anashukia :',
          LangConstants.ac_ag_bs_lis_fare: 'Nauli :',
          LangConstants.ac_tic_print: ' Printi',
          LangConstants.ac_tic_pay_submit: ' MALIZIA',
          LangConstants.ac_rsv_li_rt: ' Ruti',
          LangConstants.str_male: ' M/Mme',
          LangConstants.ac_ag_dash_profile: ' Profaili',
          LangConstants.ag_cg_pwd: ' Badili Nywila',
          LangConstants.str_female: 'M/Mke',
          LangConstants.ac_sv_ps_det_lst_name: 'Jina la mwisho',
          LangConstants.ac_sv_ps_det_mobl_no: 'Namba ya simu',
          LangConstants.kin_name: 'Jina Lake',
          LangConstants.kin_mobile: 'Namba yake ya Simu',
          LangConstants.ac_sv_ps_det_vtr_card_1: 'Cha Mpiga Kura',
          LangConstants.ac_sv_ps_det_vtr_card_2: 'Namba ya Mpiga Kura',
          LangConstants.ac_sv_ps_det_passport_1: 'Namba ya',
          LangConstants.ac_sv_ps_det_other_id_2: 'Kingine',
          LangConstants.ac_tic_pay_eml: 'Baruapepe',
          LangConstants.ac_sv_ps_det_other_id_1: 'Pasipoti',
          LangConstants.ac_sv_ps_det_drv_lic_1: 'Leseni ya',
          LangConstants.ac_sv_ps_det_drv_lic_2: 'Udereva',
          LangConstants.ac_tic_acbar_title: 'Printi Tiketi',
          LangConstants.diptech: 'Karibu Afritek',
        }
      };
}
