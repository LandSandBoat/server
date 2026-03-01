-----------------------------------
-- Module: Job Adjustments (Wings of the Goddess Era)
-- Desc: Removes traits/abilities/effects that were added to jobs during the WotG era
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('wotg_job_adjustments')

-----------------------------------
-- Dark Knight
-----------------------------------

-- Arcane Circle: Removes WotG resist/defense/attack circle mods
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(07/20/2009)
m:addOverride('xi.effects.arcane_circle.onEffectGain', function(target, effect)
    effect:addMod(xi.mod.ARCANA_KILLER, effect:getPower())
end)

-----------------------------------
-- Ranger
-----------------------------------

-- Camouflage: Remove reduced enmity and chance to retain after ranged attack
m:addOverride('xi.effects.camouflage.onEffectGain', function(target, effect)
end)

-- Unlimited Shot: In WotG era, removed on any ranged attack, not just successful hits
m:addOverride('xi.effects.unlimited_shot.onEffectGain', function(target, effect)
end)

-----------------------------------
-- Ninja
-----------------------------------

-- Mijin Gakure: Now applies weakness and normal HP gain on raise
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(07/20/2009)
m:addOverride('xi.job_utils.ninja.useMijinGakure', function(player, target, ability, action)
    local dmg        = math.floor(player:getHP() * 0.8)
    local resist     = xi.combat.magicHitRate.calculateResistRate(player, target, 0, 0, 0, xi.element.NONE, xi.mod.INT, 0, 0)
    local tmdaFactor = xi.combat.damage.calculateDamageAdjustment(target, false, true, false, false)
    local jpFactor   = 1 + player:getJobPointLevel(xi.jp.MIJIN_GAKURE_EFFECT) * 0.03

    dmg = math.floor(dmg * resist)
    dmg = math.floor(dmg * tmdaFactor)
    dmg = math.floor(dmg * jpFactor)
    dmg = utils.handleStoneskin(target, dmg)

    target:takeDamage(dmg, player, xi.attackType.SPECIAL, xi.damageType.ELEMENTAL)
    player:setHP(0)

    return dmg
end)

-----------------------------------
-- Dragoon
-----------------------------------

-- Wyvern: Revert experience points Wyvern system
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(03/11/2008)
m:addOverride('xi.job_utils.dragoon.addWyvernExp', function(player, exp)
    return 0
end)

-- Wyvern Spawn: Remove EXPERIENCE_POINTS listener that feeds wyvern EXP system
m:addOverride('xi.pets.wyvern.onMobSpawn', function(mob)
    super(mob)

    local master = mob:getMaster()
    master:removeListener('PET_WYVERN_EXP')
end)

return m
