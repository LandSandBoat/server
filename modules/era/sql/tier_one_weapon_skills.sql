-- Until early 2010 the first weapon skill for each weapon was added at skill level 10 for that weapon. Retail changed the skill level to 5 sometime in early 2010.
-- It should be noted that the tutorial will still tell players that they will get their weapon skill at skill level 5 for their respective weapon.
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
