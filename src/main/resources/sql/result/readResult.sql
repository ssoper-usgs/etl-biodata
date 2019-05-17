select 
    activity_swap_biodata.data_source_id,-- DNM
    activity_swap_biodata.data_source,-- DNM
    activity_swap_biodata.station_id,
    activity_swap_biodata.site_id,
    activity_swap_biodata.event_date,
    activity_swap_biodata.activity,
    result.characteristic       characteristic_name,
    'Biological'                characteristic_type,-- DNM
    activity_swap_biodata.sample_media,
    activity_swap_biodata.organization,
    activity_swap_biodata.site_type,
    activity_swap_biodata.huc,
    activity_swap_biodata.governmental_unit_code,
    activity_swap_biodata.organization_name,
    activity_swap_biodata.activity_id,
    activity_swap_biodata.activity_type_code,
    activity_swap_biodata.activity_media_subdiv_name,
    activity_swap_biodata.activity_start_time,
    activity_swap_biodata.act_start_time_zone,
    activity_swap_biodata.activity_stop_date,
    activity_swap_biodata.activity_stop_time,
    activity_swap_biodata.act_stop_time_zone,
    activity_swap_biodata.activity_relative_depth_name,
    activity_swap_biodata.activity_depth,
    activity_swap_biodata.activity_depth_unit,
    activity_swap_biodata.activity_depth_ref_point,
    activity_swap_biodata.activity_upper_depth,
    activity_swap_biodata.activity_upper_depth_unit,
    activity_swap_biodata.activity_lower_depth,
    activity_swap_biodata.activity_lower_depth_unit,
    activity_swap_biodata.project_id,
    activity_swap_biodata.activity_conducting_org,
    activity_swap_biodata.activity_comment,
    activity_swap_biodata.activity_latitude,
    activity_swap_biodata.activity_longitude,
    activity_swap_biodata.activity_source_map_scale,
    activity_swap_biodata.act_horizontal_accuracy,
    activity_swap_biodata.act_horizontal_accuracy_unit,
    activity_swap_biodata.act_horizontal_collect_method,
    activity_swap_biodata.act_horizontal_datum_name,
    activity_swap_biodata.assemblage_sampled_name,
    activity_swap_biodata.act_collection_duration,
    activity_swap_biodata.act_collection_duration_unit,
    activity_swap_biodata.act_sam_compnt_name,
    activity_swap_biodata.act_sam_compnt_place_in_series,
    activity_swap_biodata.act_reach_length,
    activity_swap_biodata.act_reach_length_unit,
    activity_swap_biodata.act_reach_width,
    activity_swap_biodata.act_reach_width_unit,
    activity_swap_biodata.act_pass_count,
    activity_swap_biodata.net_type_name,
    activity_swap_biodata.act_net_surface_area,
    activity_swap_biodata.act_net_surface_area_unit,
    activity_swap_biodata.act_net_mesh_size,
    activity_swap_biodata.act_net_mesh_size_unit,
    activity_swap_biodata.act_boat_speed,
    activity_swap_biodata.act_boat_speed_unit,
    activity_swap_biodata.act_current_speed,
    activity_swap_biodata.act_current_speed_unit,
    activity_swap_biodata.toxicity_test_type_name,
    activity_swap_biodata.sample_collect_method_id,
    activity_swap_biodata.sample_collect_method_ctx,
    activity_swap_biodata.sample_collect_method_name,
    activity_swap_biodata.act_sam_collect_meth_qual_type,
    activity_swap_biodata.act_sam_collect_meth_desc,
    activity_swap_biodata.sample_collect_equip_name,
    activity_swap_biodata.act_sam_collect_equip_comments,
    activity_swap_biodata.act_sam_prep_meth_id,
    activity_swap_biodata.act_sam_prep_meth_context,
    activity_swap_biodata.act_sam_prep_meth_name,
    activity_swap_biodata.act_sam_prep_meth_qual_type,
    activity_swap_biodata.act_sam_prep_meth_desc,
    activity_swap_biodata.sample_container_type,
    activity_swap_biodata.sample_container_color,
    activity_swap_biodata.act_sam_chemical_preservative,
    activity_swap_biodata.thermal_preservative_name,
    activity_swap_biodata.act_sam_transport_storage_desc,
    result.result_id,
    result.result_value         result_measure_value,
    case result.characteristic
        when 'Weight' then 'g'
        when 'Fish standard length' then 'mm'
        when 'Length, Total (Fish)' then 'mm'
        else null
        end                     result_unit,-- DNM
    'Final'                     result_value_status,-- DNM
    'Actual'                    result_value_type,-- DNM
    'Population Census'         biological_intent,-- DNM
    result.res_bio_individual_id,
    result.published_taxon_name sample_tissue_taxonomic_name,
    result.unidentified_species_identifier,
    result.group_weight         res_group_summary_ct_wt,
    case
         when result.group_weight is not null then 'g'
        else null
        end                     res_group_summary_ct_wt_unit,
from
    activity_swap_biodata
        join
            biodata.result result
            on
                activity_swap_biodata.activity_id = result.dw_effort_id
order by
    activity_swap_biodata.station_id;