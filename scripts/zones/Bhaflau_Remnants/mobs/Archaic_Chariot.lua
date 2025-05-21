-----------------------------------
-- Area: Bhaflau Remnants
--  MOB: Archaic Chariot
-----------------------------------
mixins = { require('scripts/mixins/families/chariot') }
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.UDMGMAGIC, -170)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local instance = mob:getInstance()
        if instance then
            instance:setLocalVar('bossModifier', instance:getProgress())
        end

        xi.salvage.spawnTempChest(mob)
    end
end

return entity
