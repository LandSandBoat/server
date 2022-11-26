-----------------------------------
-- Area: Mamook
--  ZNM: Chamrosh (Tier-1 ZNM)
-- Does not use normal colibri mimic mechanics, changes form every
-- 2.5 mins. st form mimics all spells 2nd form cast spells from list only
-- todo: when mimics a spell will cast the next tier spell
-----------------------------------
mixins = { require("scripts/mixins/rage") }
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:setLocalVar("changeTime", 150)
    mob:setLocalVar("useWise", math.random(25, 50))
    mob:addMod(xi.mod.UFASTCAST, 150)
end

entity.onMobFight = function(mob, target)
    local delay = mob:getLocalVar("delay")
    -- local lastCast = mob:getLocalVar("LAST_CAST")
    local spell = mob:getLocalVar("COPY_SPELL")
    local changeTime = mob:getLocalVar("changeTime")

    if spell > 0 and not mob:hasStatusEffect(xi.effect.SILENCE) then
        if delay >= 3 then
            mob:castSpell(spell)
            mob:setLocalVar("COPY_SPELL", 0)
            mob:setLocalVar("delay", 0)
        else
            mob:setLocalVar("delay", delay + 1)
        end
    end

    if
        mob:getHPP() < mob:getLocalVar("useWise") and
        mob:getLocalVar("usedMainSpec") == 0
    then
        mob:useMobAbility(1702)
        mob:setLocalVar("usedMainSpec", 1)
    end

    if mob:getBattleTime() == changeTime then
        if mob:getAnimationSub() == 0 then
            mob:setAnimationSub(1)
            mob:setSpellList(0)
            mob:setLocalVar("changeTime", mob:getBattleTime() + 150)
        else
            mob:setAnimationSub(0)
            mob:setSpellList(302)
            mob:setLocalVar("changeTime", mob:getBattleTime() + 150)
        end
    end
end

entity.onMagicHit = function(caster, target, spell)
    if
        spell:tookEffect() and
        target:getAnimationSub() == 1 and
        (caster:isPC() or caster:isPet())
    then
        target:setLocalVar("COPY_SPELL", spell:getID())
        target:setLocalVar("LAST_CAST", target:getBattleTime())
    end

    return 1
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
