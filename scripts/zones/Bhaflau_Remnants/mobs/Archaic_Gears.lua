-----------------------------------
-- Area: Bhaflau Remnants
--  MOB: Archaic Gears
--
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_REMNANTS]
mixins = { require('scripts/mixins/families/gear') }
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local instance = mob:getInstance()

        if instance and instance:getStage() == 3 then
            local dormantTime = instance:getLocalVar('gearDeath')
            local time = GetSystemTime()
            if dormantTime == 0 then
                instance:setLocalVar('gearDeath', time + 6)
            -- 6 seconds to kill both gears to spawn the Dormant Rampart
            elseif dormantTime >= time then
                if mob:getID() == ID.mob.ARCHAIC_GEARS[2] then
                    instance:setLocalVar('dormantArea', 2)
                    GetNPCByID(ID.npc.DORMANT_RAMPART[3], instance):setPos(-497, -4, -420, 252)
                end

                instance:setLocalVar('dormantArea', 1)
                GetNPCByID(ID.npc.DORMANT_RAMPART[3], instance):setStatus(xi.status.NORMAL)
            end
        end

        xi.salvage.spawnTempChest(mob)
    end
end

return entity
