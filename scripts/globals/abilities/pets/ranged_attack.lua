---------------------------------------------------
-- Ranged Attack
---------------------------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/automatonweaponskills")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onPetAbility(target, automaton, skill, master, action)
    local params = {
        numHits = 1,
        atkmulti = 1.5,
        ftp100 = 1.0,
        ftp200 = 1.0,
        ftp300 = 1.0,
        acc100 = 0.0,
        acc200 = 0.0,
        acc300 = 0.0,
        str_wsc = 0.5,
        dex_wsc = 0.25,
        vit_wsc = 0.0,
        agi_wsc = 0.0,
        int_wsc = 0.0,
        mnd_wsc = 0.0,
        chr_wsc = 0.0
    }

    local damage = doAutoRangedWeaponskill(automaton, target, 0, params, 1000, true, skill, action)

    return damage
end
