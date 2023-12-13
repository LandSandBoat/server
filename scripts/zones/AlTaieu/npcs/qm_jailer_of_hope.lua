-----------------------------------
-- Area: Al'Taieu
--  NPC: qm_jailer_of_hope (???)
-- Allows players to spawn the Jailer of Hope by trading the First Virtue, Deed of Placidity and HQ Phuabo Organ to a ???.
-- !pos -693 -1 -62 33
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- JAILER OF HOPE
    if
        not GetMobByID(ID.mob.JAILER_OF_HOPE):isSpawned() and
        trade:hasItemQty(1850, 1) and -- first_virtue
        trade:hasItemQty(1851, 1) and -- deed_of_placidity
        trade:hasItemQty(1852, 1) and -- high-quality_phuabo_organ
        trade:getItemCount() == 3 and
        npcUtil.popFromQM(player, npc, { ID.mob.JAILER_OF_HOPE }, { claim = false })
    then
        player:tradeComplete()
        GetMobByID(ID.mob.JAILER_OF_HOPE):timer(3000, function(mobArg)
            if
                player and
                player:isAlive() and
                player:getZoneID() == mobArg:getZoneID()
            then
                mobArg:updateClaim(player)
            else
                -- failsafe if the player pops and warps, or pops and dies
                -- get the jailer out of the water
                mobArg:hideName(false)
                mobArg:setUntargetable(false)
                mobArg:setAnimationSub(6)
            end
        end)
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
