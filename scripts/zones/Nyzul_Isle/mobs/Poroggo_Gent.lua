-----------------------------------
--  MOB: Poroggo Gent
-- Area: Nyzul Isle
-- Info: Specified Mob Group
-----------------------------------
mixins = { require('scripts/mixins/families/poroggo') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.specifiedGroupKill(mob)
        local instance = mob:getInstance()
        if not instance then
            return
        end

        local chars    = instance:getChars()

        for _, entities in ipairs(chars) do
            if player:hasStatusEffect(xi.effect.COSTUME) then
                player:delStatusEffect(xi.effect.COSTUME)
            end
        end
    end
end

return entity
