-----------------------------------
-- Ability: Shadowbind
-- Roots enemy in place.
-- Obtained: Ranger Level 40
-- Recast Time: 5:00
-- Duration: 00:30
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if ((player:getWeaponSkillType(xi.slot.RANGED) == xi.skill.MARKSMANSHIP and player:getWeaponSkillType(xi.slot.AMMO) == xi.skill.MARKSMANSHIP) or
    (player:getWeaponSkillType(xi.slot.RANGED) == xi.skill.ARCHERY and player:getWeaponSkillType(xi.slot.AMMO) == xi.skill.ARCHERY)) then
        return 0, 0
    end
    return 216, 0 -- You do not have an appropriate ranged weapon equipped.
end

ability_object.onUseAbility = function(player, target, ability, action)

    if (player:getWeaponSkillType(xi.slot.RANGED) == xi.skill.MARKSMANSHIP) then -- can't have your crossbow/gun held like a bow, now can we?
        action:setAnimation(target:getID(), action:getAnimation(target:getID()) + 1)
    end

    local duration = 30 + player:getMod(xi.mod.SHADOW_BIND_EXT) + player:getJobPointLevel(xi.jp.SHADOWBIND_DURATION)
    local recycleChance = player:getMod(xi.mod.RECYCLE) + player:getMerit(xi.merit.RECYCLE)
    if (player:hasStatusEffect(xi.effect.UNLIMITED_SHOT)) then
        player:delStatusEffect(xi.effect.UNLIMITED_SHOT)
        recycleChance = 100
    end

     -- TODO: Acc penalty for /RNG, acc vs. mob level?
    if (math.random(0, 99) >= target:getMod(xi.mod.BINDRES) and target:hasStatusEffect(xi.effect.BIND) == false) then
        target:addStatusEffect(xi.effect.BIND, 0, 0, duration)
        ability:setMsg(xi.msg.basic.IS_EFFECT) -- Target is bound.
    else
        ability:setMsg(xi.msg.basic.JA_MISS) -- Player uses Shadowbind, but misses.
    end

    if (math.random(0, 99) >= recycleChance) then
        player:removeAmmo() -- Shadowbind depletes one round of ammo.
    end

    return xi.effect.BIND
end

return ability_object
