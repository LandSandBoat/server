-----------------------------------
require('scripts/events/handler')
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
    local serverMessage = ''

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

xi.server.setExplorerMoogles = function(moogleId)
    if xi.settings.main.EXPLORER_MOOGLE_LV ~= 0 then
        local npc = GetNPCByID(moogleId)
        if npc == nil then
            printf('SetExplorerMoogles: Error trying to load undefined npc (%d)', moogleId)
        else
            npc:setStatus(0)
        end
    end
end

return xi.server
