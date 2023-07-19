-----------------------------------
require("scripts/globals/events/handler")
-----------------------------------

xi = xi or {}
xi.server = xi.server or {}

xi.server.onServerStart = function()
    xi.events.handler.checkSeasonalEvents()
end

xi.server.onJSTMidnight = function()
    xi.events.handler.checkSeasonalEvents()
end

xi.server.onTimeServerTick = function()
end

-- Message for use with SmallPacket0x04B
xi.server.getServerMessage = function(language)
    local serverMessage = ""

    if language == xi.language.ENGLISH then
        serverMessage = xi.settings.main.SERVER_MESSAGE

        if xi.settings.main.ENABLE_TRUST_ALTER_EGO_EXTRAVAGANZA_ANNOUNCE == 1 then
            serverMessage = serverMessage .. xi.settings.main.TRUST_ALTER_EGO_EXTRAVAGANZA_MESSAGE
        end

        if xi.settings.main.ENABLE_TRUST_ALTER_EGO_EXPO_ANNOUNCE == 1 then
            serverMessage = serverMessage .. xi.settings.main.TRUST_ALTER_EGO_EXPO_MESSAGE
        end
    end

    return serverMessage
end

return xi.server
