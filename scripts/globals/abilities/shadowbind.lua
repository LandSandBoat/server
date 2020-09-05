-----------------------------------
-- Ability: Shadowbind
-- Roots enemy in place.
-- Obtained: Ranger Level 40
-- Recast Time: 5:00
-- Duration: 00:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if ((player:getWeaponSkillType(tpz.slot.RANGED) == tpz.skill.MARKSMANSHIP and player:getWeaponSkillType(tpz.slot.AMMO) == tpz.skill.MARKSMANSHIP) or
    (player:getWeaponSkillType(tpz.slot.RANGED) == tpz.skill.ARCHERY and player:getWeaponSkillType(tpz.slot.AMMO) == tpz.skill.ARCHERY)) then
        return 0, 0
    end
    return 216, 0 -- You do not have an appropriate ranged weapon equipped.
end

function onUseAbility(player, target, ability, action)

    if (player:getWeaponSkillType(tpz.slot.RANGED) == tpz.skill.MARKSMANSHIP) then -- can't have your crossbow/gun held like a bow, now can we?
        action:animation(target:getID(), action:animation(target:getID()) + 1)
    end

    local duration = 30 + player:getMod(tpz.mod.SHADOW_BIND_EXT)
    local recycleChance = player:getMod(tpz.mod.RECYCLE) + player:getMerit(tpz.merit.RECYCLE)
    if (player:hasStatusEffect(tpz.effect.UNLIMITED_SHOT)) then
        player:delStatusEffect(tpz.effect.UNLIMITED_SHOT)
        recycleChance = 100
    end

     -- TODO: Acc penalty for /RNG, acc vs. mob level?
    if (math.random(0, 99) >= target:getMod(tpz.mod.BINDRES) and target:hasStatusEffect(tpz.effect.BIND) == false) then
        target:addStatusEffect(tpz.effect.BIND, 0, 0, duration)
        ability:setMsg(tpz.msg.basic.IS_EFFECT) -- Target is bound.
    else
        ability:setMsg(tpz.msg.basic.JA_MISS) -- Player uses Shadowbind, but misses.
    end

    if (math.random(0, 99) >= recycleChance) then
        player:removeAmmo() -- Shadowbind depletes one round of ammo.
    end

    return tpz.effect.BIND
end
