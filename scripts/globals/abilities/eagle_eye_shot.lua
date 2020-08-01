-----------------------------------
-- Ability: Eagle Eye Shot
-- Delivers a powerful and accurate ranged attack.
-- Obtained: Ranger Level 1
-- Recast Time: 1:00:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/weaponskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    local ranged = player:getStorageItem(0, 0, tpz.slot.RANGED)
    local ammo = player:getStorageItem(0, 0, tpz.slot.AMMO)

    if ranged and ranged:isType(tpz.itemType.WEAPON) then
        local skilltype = ranged:getSkillType()
        if skilltype == tpz.skill.ARCHERY or skilltype == tpz.skill.MARKSMANSHIP or skilltype == tpz.skill.THROWING then
            if ammo and (ammo:isType(tpz.itemType.WEAPON) or skilltype == tpz.skill.THROWING) then
                return 0, 0
            end
        end
    end

    return tpz.msg.basic.NO_RANGED_WEAPON, 0
end

function onUseAbility(player, target, ability, action)
    if (player:getWeaponSkillType(tpz.slot.RANGED) == tpz.skill.MARKSMANSHIP) then
        action:animation(target:getID(), action:animation(target:getID()) + 1)
    end
    local params = {}
    params.numHits = 1
    local ftp = 5
    params.ftp100 = ftp params.ftp200 = ftp params.ftp300 = ftp
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = true
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1 params.atk200 = 1 params.atk300 = 1
    params.enmityMult = 0.5

    local damage, criticalHit, tpHits, extraHits = doRangedWeaponskill(player, target, 0, params, 0, action, true)

    -- Set the message id ourselves
    if (tpHits + extraHits > 0) then
        action:messageID(target:getID(), tpz.msg.basic.JA_DAMAGE)
        action:speceffect(target:getID(), 32)
    else
        action:messageID(target:getID(), tpz.msg.basic.JA_MISS_2)
        action:speceffect(target:getID(), 0)
    end

    return damage
end
