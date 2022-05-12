------------------------------------
-- Override specific mission/quest functions
-----------------------------------
require("modules/module_utils")
-----------------------------------
local m = Module:new("cop_trusts")
m:setEnabled(true)

m:addOverride("xi.zones.Tavnazian_Safehold.npcs._0qa.onTrigger", function(player, npc)
    if (player:getCurrentMission(COP) == xi.mission.id.cop.CHAINS_AND_BONDS and player:getCharVar("PromathiaStatus")==4) then
        player:startEvent(115)
    elseif (player:getCurrentMission(COP) == xi.mission.id.cop.DAWN and player:getCharVar("PromathiaStatus")==5) then
        player:startEvent(543)
	end	
	
    if player:getCurrentMission(COP) >= xi.mission.id.cop.DAWN then
        player:addSpell(913) -- Prishe
    end
end)

m:addOverride("xi.zones.Misareaux_Coast.npcs._0p0.onTrigger", function(player, npc)
    if player:getCurrentMission(COP) >= xi.mission.id.cop.DAWN then
        player:addSpell(914) -- Ulmia
    end

	player:messageSpecial(ID.text.SNOWMINT_POINT_LOCKED)
end)

return m