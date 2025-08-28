-----------------------------------
-- Area: Lower Jeuno
-- NPC: Rakuru-Rakoru
-------------------------------------
require("scripts/globals/conquest")
require("scripts/globals/era_npc")
-----------------------------------

local guardNation = xi.nation.OTHER
local guardType   = xi.conquest.guard.CITY
local guardEvent  = 32763

local entity = {}

entity.onTrade = function(player, npc, trade)
	xi.conquest.overseerOnTrade(player, npc, trade, guardNation, guardType)
end

entity.onTrigger = function(player, npc)
    if xi.eraNpc.giveInstantWarpScroll(player, npc, { name = "Rakuru-Rakoru" }) then
        return
    end

	xi.conquest.overseerOnTrigger(player, npc, guardNation, guardType, guardEvent)
end

entity.onEventUpdate = function(player, csid, option)
	xi.conquest.overseerOnEventUpdate(player, csid, option, guardNation)
end

entity.onEventFinish = function(player, csid, option)
	xi.conquest.overseerOnEventFinish(player, csid, option, guardNation, guardType)
end

return entity
