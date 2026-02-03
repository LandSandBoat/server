------------------------------------
-- WotG Tier One Weapon Skills Reversion
-- This module reverts all starter weaponskills from 5 to 10 skill
-- Note: Tutorial text still states 5 skill level
------------------------------------
-- Source : https://www.bg-wiki.com/ffxi/Version_Update_(09/08/2008)
-----------------------------------

UPDATE weapon_skills
SET
    skilllevel = 10
WHERE
    name IN (
        "combo",
        "wasp_sting",
        "fast_blade",
        "hard_slash",
        "raging_axe",
        "shield_break",
        "slice",
        "double_thrust",
        "blade_rin",
        "tachi_enpi",
        "shining_strike",
        "heavy_swing",
        "flaming_arrow",
        "hot_shot"
    );
