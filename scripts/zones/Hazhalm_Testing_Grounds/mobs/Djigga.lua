-----------------------------------
-- Area: Hazhalm Testing Grounds
--   Mob: Djigga (Einherjar)
-- Notes: Attacks absorb buffs silently from players.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    if math.random(1, 100) <= 25 then
        -- last argument is true to hide the "effect lost" message from the player
        local result = mob:stealStatusEffect(target, xi.effectFlag.DISPELABLE, true)
        if result == 0 then
            return 0, 0, 0
        end

        return xi.subEffect.STATUS_DRAIN, xi.msg.basic.NONE, result
    end

    return 0, 0, 0
end

return entity
