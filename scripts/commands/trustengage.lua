-----------------------------------
-- func: trustengage
-- desc: Sets the engagement type of a players trusts
-----------------------------------
require("scripts/globals/settings")

cmdprops =
{
    permission = 0,
    parameters = "i"
}

local types =
{
    [0] = { 0, "Retail: Master engage and melee swing" },
    [1] = { 1, "Attack: Master engage" },
}

function error(player)
    player:PrintToPlayer(string.format("!trustengage <type number>\n" ..
    "0: %s\n" ..
    "1: %s", types[0][2], types[1][2]))
    local type = player:getCharVar("TrustEngageType")
    player:PrintToPlayer(string.format("Currently set to:\n %i: %s", type, types[type][2]))
end

function onTrigger(player, type)
    if xi.settings.main.ENABLE_TRUST_CUSTOM_ENGAGEMENT ~= 1 then
        player:PrintToPlayer("Trust custom engage conditions are disabled.")
        return
    end

    if type == nil or type < 0 or type > 1 then
        error(player)
    end

    player:setCharVar("TrustEngageType", type)
    player:PrintToPlayer(string.format("Set Trust engage type to: %i: %s", type, types[type][2]))
end
