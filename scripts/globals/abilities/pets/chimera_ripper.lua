---------------------------------------------------
-- Chimera Ripper
---------------------------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/automatonweaponskills")

---------------------------------------------------
local ability_object = {}

function onMobSkillCheck(target, automaton, skill)
    local master = automaton:getMaster()
    return master:countEffect(tpz.effect.FIRE_MANEUVER)
end

ability_object.onPetAbility = function(target, automaton, skill, master, action)
    local params = {
        numHits = 1,
        atkmulti = 1,
        accBonus = 100,
        weaponType = tpz.skill.SWORD,
        ftp100 = 1.5,
        ftp200 = 2.0,
        ftp300 = 3.0,
        acc100 = 0.0,
        acc200 = 0.0,
        acc300 = 0.0,
        str_wsc = 0.5,
        dex_wsc = 0.0,
        vit_wsc = 0.0,
        agi_wsc = 0.0,
        int_wsc = 0.0,
        mnd_wsc = 0.0,
        chr_wsc = 0.0
    }

    if USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftp100 = 6.0
        params.ftp200 = 8.5
        params.ftp300 = 11.0
    end

    local damage = doAutoPhysicalWeaponskill(automaton, target, 0, skill:getTP(), true, action, false, params, skill, action)

    return damage
end

return ability_object
