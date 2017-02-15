SELECT	
-- flight info
		' ' break1,
		(select lookup_short_desc from helios.lookup l where l.lookup_id = aa.aircraft_type_id) config,
		flt.callsign,

		(select lookup_cd from helios.lookup l where l.lookup_id = flt.takeoff_icao_code_id) to_loc_sked,
		(select lookup_cd from helios.lookup l where l.lookup_id = flt.land_icao_code_id) land_loc_sked,
		
		to_char(flt.takeoff_date_time, 'dd-Mon-yyyy hh24mi') to_dtg_sked,
		to_char(flt.actual_takeoff_date_time, 'dd-Mon-yyyy hh24mi') to_dtg_act,
		to_char(flt.land_date_time, 'dd-Mon-yyyy hh24mi') land_dtg_sked,
		to_char(flt.actual_land_date_time, 'dd-Mon-yyyy hh24mi') land_dtg_act,

		(select lookup_short_desc from helios.lookup l where l.lookup_id = flt.current_status_id) flt_stat,
		(select lookup_short_desc from helios.lookup l where l.lookup_id = flt.reason_id) flt_stat_rsn,
		(select agency_cd from helios.agency a where a.agency_id = flt.tacon_id) flt_tacon,

-- mission info
		' ' break2,
		(select lookup_short_desc from helios.lookup l where l.lookup_id = msn.mission_type_id) msn_type,
		(select lookup_short_desc from helios.lookup l where l.lookup_id = msn.area_id) msn_area,
		
		to_char(msn.onstn_actual_dtg, 'dd-Mon-yyyy hh24mi') on_sta_dtg_act,
		to_char(msn.offstn_actual_dtg, 'dd-Mon-yyyy hh24mi') off_sta_dtg_act,

		(select lookup_short_desc from helios.lookup l where l.lookup_id = msn.current_status_id) msn_stat,
		(select lookup_short_desc from helios.lookup l where l.lookup_id = msn.reason_id) msn_stat_rsn,

		(select operation_nm from helios.named_operation no where no.op_id = msn.named_op_id) msn_supp_op,
		
		(select agency_cd from helios.agency a where a.agency_id = msn.tacon_id) msn_tacon,

-- primary key ids
		flt.flight_id flt_id,
		(select air_asset_id from helios.deployment d where d.deployment_id = flt.deployment_id) air_asset_id,
		aa.aircraft_type_id,
		
		flt.takeoff_icao_code_id to_loc_sked_id,
		flt.land_icao_code_id land_loc_sked_id, 

		flt.current_status_id flt_stat_id, 
		flt.reason_id flt_stat_rsn_id, 
		flt.tacon_id flt_tacon_id,

		msn.mission_type_id msn_type_id,  
		msn.area_id msn_area_id,
		msn.current_status_id msn_stat_id, 
		msn.reason_id msn_reason_id, 
		
		msn.named_op_id msn_supp_op_id,
		msn.tacon_id msn_tacon_id,
		' ' lst_col

	from	helios.flight flt, helios.mission msn, helios.deployment d, helios.air_asset aa
--  where flight_id = $1
	WHERE	flt.takeoff_date_time 
		between $1 AND $2
--		between '1/8/2016 00:00:00' AND '3/22/2017 23:59:59'
--		between '08-jan-2016 00:00:00' AND '22-mar-2017 23:59:59'
--		between '22-mar-2016 00:00:00' AND '22-mar-2016 23:59:59'
	and	msn.flight_id = flt.flight_id
	and 	flt.deployment_id = d.deployment_id
	and	d.air_asset_id = aa.air_asset_id
order by flt.takeoff_date_time, msn.mission_start_date_time
