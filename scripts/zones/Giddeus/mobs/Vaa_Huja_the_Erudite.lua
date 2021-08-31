-----------------------------------
-- Area: Giddeus
--   NM: Vaa Huja the Erudite
-- Involved in Quests: Dark Legacy
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    local darkLegacyCS = player:getCharVar("darkLegacyCS")

    if (darkLegacyCS == 3 or darkLegacyCS == 4) then
        player:setCharVar("darkLegacyCS", 5)
    end
end

return entity
