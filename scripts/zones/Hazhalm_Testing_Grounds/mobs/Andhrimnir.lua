-----------------------------------
-- Area: Hazhalm Testing Grounds
--   NM: Andhrimnir (Einherjar)
-- Notes: Every minute, vanishes for a couple seconds before
-- teleporting to a random player and charming them with Danse Macabre.
-- Resists Bind/Blind/Gravity
-- No standback
-----------------------------------
mixins =
{
    require('scripts/mixins/draw_in'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

local function vanish(mob)
    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(false)
    mob:setMobAbilityEnabled(false)
    mob:entityAnimationPacket(xi.animationString.STATUS_DISAPPEAR)
    mob:hideName(true)
    mob:setUntargetable(true)
    mob:timer(3000, function(mobArg)
        mobArg:setStatus(xi.status.INVISIBLE)
    end)
end

local function reset(mob)
    mob:hideName(false)
    mob:setUntargetable(false)
    mob:entityAnimationPacket(xi.animationString.STATUS_VISIBLE)
    mob:setStatus(xi.status.UPDATE)
    mob:setAutoAttackEnabled(true)
    mob:timer(1000, function(mobArg)
        -- Slight delay so it doesn't try to cast before Danse Macabre
        mobArg:setMagicCastingEnabled(true)
    end)

    mob:setMobAbilityEnabled(true)
end

entity.onMobInitialize = function(mob)
    xi.einherjar.onBossInitialize(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.SILENCE)

    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobFight = function(mob, target)
    -- Don't process if the mob is busy
    if mob:getCurrentAction() ~= xi.action.ATTACK then
        return
    end

    if mob:getLocalVar('nextCharm') <= GetSystemTime() then
        local victim = utils.randomEntry(utils.filter(mob:getEnmityList(), function(k, v)
            return v.entity and v.entity:isAlive() and v.entity:isPC()
        end))

        -- If we couldn't find anyone in the enmity list, use current passive target.
        if not victim then
            victim = target
        else
            victim = victim.entity
        end

        vanish(mob)
        mob:setLocalVar('nextCharm', GetSystemTime() + math.random(60, 70))

        -- After 5 seconds, reappear next to victim and use Danse Macabre
        mob:timer(5000, function(mobArg)
            if not victim or not victim:isAlive() then
                reset(mobArg)
                return
            end

            mobArg:setPos(victim:getXPos() - 1, victim:getYPos() + 3, victim:getZPos(), 0)
            mobArg:facePlayer(victim)

            reset(mobArg)
            mobArg:useMobAbility(xi.mobSkill.DANSE_MACABRE, victim)
        end)
    end
end

entity.onMobDisengage = reset

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('nextCharm', GetSystemTime() + math.random(60, 70))
end

return entity
