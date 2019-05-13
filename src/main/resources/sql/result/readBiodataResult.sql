select activity_swap_biodata.data_source_id,
       activity_swap_biodata.data_source,
       activity_swap_biodata.station_id,
       activity_swap_biodata.site_id,
       activity_swap_biodata.event_date,
       activity_swap_biodata.activity,
       result.characteristic       characteristic_name,
       'Biological'                characteristic_type,
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
           end                     result_unit,
       'Final'                     result_value_status,
       'Actual'                    result_value_type,
       'Population Census'         biological_intent,
       result.res_bio_individual_id,
       result.published_taxon_name sample_tissue_taxonomic_name,
       result.UnidentifiedSpeciesIdentifier,
       result.group_weight         res_group_summary_ct_wt,
       case
           when result.group_weight is not null then 'g'
           else null
           end                     res_group_summary_ct_wt_unit,
from activity_swap_biodata
         join (
    select a.*,
           rownum result_id
    from (select taxonomic_result.dw_effort_id,
                 taxon_wide.published_taxon_name,
                 case
                     when taxonomic_result.raw_count > 1 and
                          taxonomic_result.weight > 0
                         then weight
                     else null
                     end    group_weight,
                 taxonomic_result.raw_count,
                 taxonomic_result.total_length,
                 taxonomic_result.standard_length,
                 taxonomic_result.weight,
                 taxonomic_result.field_sheet_page ||
                 nvl2(taxonomic_result.field_sheet_line,
                      '-' || taxonomic_result.field_sheet_line,
                      null) res_bio_individual_id,
                 case
                     when taxon_wide.biodata_taxon_name = taxon_wide.published_taxon_name
                         then null
                     else taxon_wide.biodata_taxon_name
                     end    UnidentifiedSpeciesIdentifier
          from biodata.taxonomic_result
                   join biodata.taxon_wide
                        on taxonomic_result.taxon_id = taxon_wide.bench_taxon_id
          where taxonomic_result.biological_community = 'Fish'
            and taxonomic_result.data_release_category = 'Public') unpivot (result_value for characteristic
                                         in (raw_count as 'Count',
                                             total_length as 'Length, Total (Fish)',
                                             standard_length as 'Fish standard length',
                                             weight as 'Weight')
        ) a
) result
              on activity_swap_biodata.activity_id = result.dw_effort_id
order by activity_swap_biodata.station_id;