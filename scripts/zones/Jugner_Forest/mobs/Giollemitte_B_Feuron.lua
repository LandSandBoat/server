-----------------------------------
-- Area: Jugner Forest
--  NM: Fraelissa
--  Quest: A timely visit
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    local party = player:getParty()

    for _, v in ipairs(party) do
        if v:getCharVar("Quest[0][105]Prog") == 6 and v:getZone() == player:getZone() then
            v:setCharVar("Quest[0][105]Prog", 7)
        end
    end
end

return entity
