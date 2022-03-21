-----------------------------------
-- func: gmhome
-- desc: Sends you to zone 210 (GM_HOME), if you are a GM
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function onTrigger(player)
    player:setPos(0, 0, 0, 0, xi.zone.GM_HOME)
end
