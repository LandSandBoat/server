import mariadb


def migration_name():
    return "Adding currency2 columns to char_points table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # Ensure daily_tally column exists in char_points
    cur.execute("SHOW COLUMNS FROM char_points LIKE 'mystical_canteen'")
    if not cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE char_points \
                ADD COLUMN `mystical_canteen` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `ghastly_stone` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `ghastly_stone_1` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `ghastly_stone_2` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `verdigris_stone` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `verdigris_stone_1` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `verdigris_stone_2` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `wailing_stone` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `wailing_stone_1` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `wailing_stone_2` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `snowslit_stone` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `snowslit_stone_1` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `snowslit_stone_2` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `snowtip_stone` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `snowtip_stone_1` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `snowtip_stone_2` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `snowdim_stone` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `snowdim_stone_1` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `snowdim_stone_2` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `snoworb_stone` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `snoworb_stone_1` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `snoworb_stone_2` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `leafslit_stone` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `leafslit_stone_1` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `leafslit_stone_2` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `leaftip_stone` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `leaftip_stone_1` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `leaftip_stone_2` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `leafdim_stone` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `leafdim_stone_1` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `leafdim_stone_2` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `leaforb_stone` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `leaforb_stone_1` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `leaforb_stone_2` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `duskslit_stone` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `duskslit_stone_1` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `duskslit_stone_2` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `dusktip_stone` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `dusktip_stone_1` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `dusktip_stone_2` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `duskdim_stone` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `duskdim_stone_1` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `duskdim_stone_2` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `duskorb_stone` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `duskorb_stone_1` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `duskorb_stone_2` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `pellucid_stone` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `fern_stone` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `taupe_stone` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `escha_beads` smallint(5) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `escha_silt` int(10) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `potpourri` int(10) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `current_hallmarks` int(10) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `total_hallmarks` int(10) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `gallantry` int(10) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `crafter_points` int(10) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `fire_crystal_set` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `ice_crystal_set` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `wind_crystal_set` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `earth_crystal_set` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `lightning_crystal_set` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `water_crystal_set` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `light_crystal_set` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `dark_crystal_set` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `mc_s_sr01_set` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `mc_s_sr02_set` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `mc_s_sr03_set` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `liquefaction_spheres_set` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `induration_spheres_set` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `detonation_spheres_set` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `scission_spheres_set` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `impaction_spheres_set` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `reverberation_spheres_set` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `transfixion_spheres_set` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `compression_spheres_set` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `fusion_spheres_set` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `distortion_spheres_set` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `fragmentation_spheres_set` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `gravitation_spheres_set` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `light_spheres_set` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `darkness_spheres_set` tinyint(3) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `silver_aman_voucher` int(10) unsigned NOT NULL DEFAULT 0;"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
