-----------------------------------
-- Chocobo Racing: Chocobuck exchange
-----------------------------------
xi = xi or {}
xi.chocoboRacing = xi.chocoboRacing or {}

xi.chocoboRacing.onChocobuckExchangeTrigger = function(player, eventId)
    player:startEvent(
        eventId,
        0 -- Member of this nation's CRA branch
    )
end

xi.chocoboRacing.onChocobuckExchangeEventUpdate = function(player, csid, option, npc)
end

xi.chocoboRacing.onChocobuckExchangeEventFinish = function(player, csid, option, npc)
end
