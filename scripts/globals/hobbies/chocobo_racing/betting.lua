-----------------------------------
-- Chocobo Racing: Betting
-- The betting counters sell quinella tickets on the two races open for bets, each counter on the races of its color.
-- Any counter pays a ticket traded to it once its race has ended.
-----------------------------------
xi = xi or {}
xi.chocoboRacing = xi.chocoboRacing or {}

-- Each counter in entity order: its events for selling, not selling and looking at a traded ticket, and the race color it handles.
local counters =
{
    { menu = 212, closed = 217, ticket = 221, color = 0 }, -- Laujaquetemps
    { menu = 213, closed = 218, ticket = 222, color = 1 }, -- Cadwyn
    { menu = 214, closed = 219, ticket = 223, color = 2 }, -- Fhaht Beablrucch
    { menu = 215, closed = 220, ticket = 224, color = 3 }, -- Failene
    { menu = 228, closed = 229, ticket = 230, color = 0 }, -- Giancario
    { menu = 267, closed = 268, ticket = 269, color = 1 }, -- Pretervout
    { menu = 271, closed = 272, ticket = 273, color = 2 }, -- Sudha Rhilimanyme
    { menu = 275, closed = 276, ticket = 277, color = 3 }, -- Gozben
    { menu = 279, closed = 280, ticket = 281, color = 0 }, -- Linus
    { menu = 283, closed = 284, ticket = 285, color = 1 }, -- Olega
    { menu = 287, closed = 288, ticket = 289, color = 2 }, -- Lengussant
    { menu = 291, closed = 292, ticket = 293, color = 3 }, -- Cordaurie
    { menu = 295, closed = 296, ticket = 297, color = 0 }, -- Roman
    { menu = 300, closed = 301, ticket = 302, color = 1 }, -- Maleroune
    { menu = 304, closed = 305, ticket = 306, color = 2 }, -- Rhap Talashpehn
    { menu = 308, closed = 309, ticket = 310, color = 3 }, -- Gerlbotz
    { menu = 312, closed = 313, ticket = 314, color = 0 }, -- Gadimo
    { menu = 316, closed = 317, ticket = 318, color = 1 }, -- Piana
    { menu = 320, closed = 321, ticket = 322, color = 2 }, -- Guillaulmilian
    { menu = 324, closed = 325, ticket = 326, color = 3 }, -- Daipanne
}

-- Update options the counter event sends: the operation in bits 0-2, the picked lanes in bits 3-6 and 7-10, the quills in bits 11-22.
local counterOp =
{
    PADDOCK = 0,
    PICK    = 1,
    BUY     = 2,
    LEAVE   = 3,
    BOARD   = 4,
}

local optionMask =
{
    OP     = 0x7,
    LANE   = 0xF,
    QUILLS = 0xFFF,
}

xi.chocoboRacing.buyResult =
{
    SOLD   = 1,
    CLOSED = 2, -- "I am currently not accepting chocobets."
    ERROR  = 3, -- "There was an error in the processing of your chocobet."
}

-- What a traded ticket turns out to be. The ticket event picks its dialogue from it.
xi.chocoboRacing.ticketStatus =
{
    ERROR   = 0, -- "There was an error in the processing of your chocobet."
    WINNER  = 1,
    LOSER   = 2,
    EXPIRED = 3, -- "The one-week grace period on your chocobet ticket has expired."
}

xi.chocoboRacing.ticketOption =
{
    COLLECT = 1,
    KEEP    = 2,
    DISPOSE = 3,
}

local betting =
{
    LANES        = 8,
    QUILL_PRICE  = 100,
    MAX_QUILLS   = 999,
    PAIR_COUNT   = 28,
    PAYOUT_SHARE = 75,    -- Gil paid back for every 100 gil bet on the race.
    NO_BET       = 50000, -- Odds of a pair nobody bet on.
    GRACE_RACES  = 672,   -- Races in the week a ticket stays good for.
}

-- Quills on each pair of the races read recently, by race number.
local pools       = {}
local poolsCached = 8

--- Quills on each of the 28 pairs of a race.
---@param raceNo integer
---@return integer[]
local function getPool(raceNo)
    if not pools[raceNo] then
        pools[raceNo] = GetChocoboRaceQuills(raceNo)

        for cachedRaceNo in pairs(pools) do
            if cachedRaceNo < raceNo - poolsCached then
                pools[cachedRaceNo] = nil
            end
        end
    end

    return pools[raceNo]
end

--- Position of a pair of 0-based lanes on the toteboard, 1 to 28. The board lists 1-2 to 1-8, then 2-3 to 2-8, down to 7-8.
---@param laneA integer
---@param laneB integer
---@return integer
local function pairOf(laneA, laneB)
    local low  = math.min(laneA, laneB)
    local high = math.max(laneA, laneB)

    -- Pairs listed ahead of this lane's own: 7 for the first lane, 6 for the second, and so on.
    local ahead = low * (15 - low) / 2

    return ahead + high - low
end

--- Gil paid per quill on each of the 28 pairs: 75% of the quills on the race, split between the quills on the pair.
---@param raceNo integer
---@return integer[]
xi.chocoboRacing.getOdds = function(raceNo)
    local pool  = getPool(raceNo)
    local total = 0
    for pair = 1, betting.PAIR_COUNT do
        total = total + pool[pair]
    end

    local odds = {}
    for pair = 1, betting.PAIR_COUNT do
        odds[pair] = betting.NO_BET
        if pool[pair] > 0 then
            -- The board reads 50000 as no bet, so real odds stop just under it.
            odds[pair] = math.min(math.floor(betting.PAYOUT_SHARE * total / pool[pair]), betting.NO_BET - 1)
        end
    end

    return odds
end

---@class ChocoboRaceQuinella
---@field first integer 0-based lane of the winner.
---@field second integer 0-based lane of the runner-up.
---@field payout integer Gil paid per quill on that pair.

--- The first two home of a race that has run, and what their pair pays.
---@param race ChocoboRaceResult
---@return ChocoboRaceQuinella
xi.chocoboRacing.getQuinella = function(race)
    local top = {}
    for lane, place in ipairs(assert(race.places)) do
        top[place] = lane - 1
    end

    return
    {
        first  = top[0],
        second = top[1],
        payout = xi.chocoboRacing.getOdds(race.raceNo)[pairOf(top[0], top[1])],
    }
end

---@param npc CBaseEntity
---@return { menu: integer, closed: integer, ticket: integer, color: integer }
local function counterOf(npc)
    local ID = zones[xi.zone.CHOCOBO_CIRCUIT]

    return counters[npc:getID() - ID.npc.COUNTER_OFFSET + 1]
end

--- The race open for bets on a color, or nil while it has none.
---@param color integer
---@return ChocoboRaceResult?
local function sellingRace(color)
    local raceNo = xi.chocoboRacing.raceNoForColor(color)

    -- Early return: betting on this color's race has closed and the next one has not opened.
    if GetSystemTime() >= xi.chocoboRacing.timeInSlot(raceNo, xi.chocoboRacing.schedule.BETS_CLOSE) then
        return nil
    end

    return xi.chocoboRacing.getRace(raceNo)
end

---@class ChocobetTicket
---@field status integer? Not set until the race has ended.
---@field raceNo integer
---@field quills integer
---@field payout integer? Gil per quill on the winning pair. Only once the race is over.
---@field first integer? 0-based lane of the winner.
---@field second integer? 0-based lane of the runner-up.

--- What the ticket in a trade turns out to be, or nil when the trade is not one ticket.
---@param trade CTradeContainer?
---@return ChocobetTicket?
local function readTicket(trade)
    -- Early return: not a ticket on its own.
    if not trade or not npcUtil.tradeHasExactly(trade, xi.item.CHOCOBET_TICKET) then
        return nil
    end

    -- The ticket carries the race number in 18 bits, so it is for the latest race to show that number.
    local exData  = trade:getItem(0):getExData()
    local current = xi.chocoboRacing.currentRaceNo()
    local raceNo  = current + 2 - (current + 2 - exData.raceId) % xi.chocoboRacing.schedule.WRAP
    local ticket  = { raceNo = raceNo, quills = exData.quills }

    if GetSystemTime() < xi.chocoboRacing.timeInSlot(raceNo, xi.chocoboRacing.schedule.END) then
        return ticket
    end

    if current - raceNo > betting.GRACE_RACES then
        ticket.status = xi.chocoboRacing.ticketStatus.EXPIRED

        return ticket
    end

    -- Runs the race now if the server was down when it was due.
    local quinella = xi.chocoboRacing.getQuinella(xi.chocoboRacing.runRace(raceNo))

    ticket.first  = quinella.first
    ticket.second = quinella.second
    ticket.payout = quinella.payout
    ticket.status = xi.chocoboRacing.ticketStatus.LOSER

    if pairOf(quinella.first, quinella.second) == pairOf(exData.racePairingL, exData.racePairingR) then
        ticket.status = xi.chocoboRacing.ticketStatus.WINNER

        -- A winning ticket on a pair with no quills recorded.
        if quinella.payout == betting.NO_BET then
            ticket.status = xi.chocoboRacing.ticketStatus.ERROR
        end
    end

    return ticket
end

---@param player CBaseEntity
---@param npc CBaseEntity
---@param trade CTradeContainer
xi.chocoboRacing.onCounterTrade = function(player, npc, trade)
    local ticket = readTicket(trade)

    -- Early return: not a ticket.
    if not ticket then
        return
    end

    -- Early return: the counter turns the ticket down without an event.
    if not ticket.status then
        player:messageText(npc, zones[xi.zone.CHOCOBO_CIRCUIT].text.RACE_NOT_DECIDED, true, 2)

        return
    end

    local winnings = 0
    if ticket.status == xi.chocoboRacing.ticketStatus.WINNER then
        winnings = ticket.payout * ticket.quills
    end

    player:startEvent(
        counterOf(npc).ticket,
        winnings,
        xi.chocoboRacing.getRaceId(ticket.raceNo),
        ticket.first or 0,
        ticket.second or 0,
        ticket.status
    )
end

---@param player CBaseEntity
---@param npc CBaseEntity
xi.chocoboRacing.onCounterTrigger = function(player, npc)
    local counter = counterOf(npc)
    local race    = sellingRace(counter.color)

    -- Early return: "We are currently not accepting chocobets."
    if not race then
        player:startEvent(counter.closed)

        return
    end

    player:startEvent(
        counter.menu,
        xi.chocoboRacing.getRaceId(race.raceNo),
        math.floor(player:getXPos() * 1000), -- PC position, in thousandths. The paddock view puts the PC back there.
        math.floor(player:getZPos() * 1000),
        math.floor(player:getYPos() * 1000),
        player:getRotPos() * 16,
        0,                                   -- Retail leaves a stale value here.
        race.weather,
        counter.color
    )
end

---@param player CBaseEntity
---@param csid integer
---@param option integer
---@param npc CBaseEntity
xi.chocoboRacing.onCounterEventUpdate = function(player, csid, option, npc)
    local counter = counterOf(npc)

    -- The ticket event asks once, for the result of the ticket's race.
    if csid == counter.ticket then
        local ticket = readTicket(player:getTrade())

        if ticket and ticket.payout then
            player:updateEvent(ticket.payout, ticket.first + 1, ticket.second + 1, ticket.second, ticket.status, 0, 0, 0)
        else
            -- Capture needed
            -- The counter reads the result out when the last parameter is 0.
            player:updateEvent(0, 0, 0, 0, 0, 0, 0, 1)
        end

        return
    end

    local op     = bit.band(option, optionMask.OP)
    local laneA  = bit.band(bit.rshift(option, 3), optionMask.LANE)
    local laneB  = bit.band(bit.rshift(option, 7), optionMask.LANE)
    local quills = bit.band(bit.rshift(option, 11), optionMask.QUILLS)
    local race   = sellingRace(counter.color)

    -- Betting closed while the menu was open.
    if not race then
        if op == counterOp.BUY then
            player:updateEvent(xi.chocoboRacing.buyResult.CLOSED)
        elseif op == counterOp.LEAVE then
            player:updateEvent(-1)
        end

        return
    end

    local ID        = zones[xi.zone.CHOCOBO_CIRCUIT]
    local closesIn  = xi.chocoboRacing.timeInSlot(race.raceNo, xi.chocoboRacing.schedule.BETS_CLOSE) - GetSystemTime()
    local validPair = laneA ~= laneB and laneA < betting.LANES and laneB < betting.LANES

    if op == counterOp.PADDOCK and laneA < betting.LANES then
        -- Capture needed
        -- Retail sends 2 in the first parameter from a counter and 6 from a toteboard.
        xi.chocoboRacing.showPaddock(player, race.chocobos[laneA + 1], 2, race.weather, counter.color * 16 + laneA * 2)
    elseif op == counterOp.BOARD then
        xi.chocoboRacing.showBoard(player, closesIn, race.weather, counter.color)
    elseif op == counterOp.PICK and validPair then
        -- The ticket this pair would print, one quill on it, and what it pays right now.
        local odds = xi.chocoboRacing.getOdds(race.raceNo)[pairOf(laneA, laneB)]
        local slip = bit.bor(xi.chocoboRacing.getRaceId(race.raceNo), bit.lshift(math.min(laneA, laneB), 24), bit.lshift(math.max(laneA, laneB), 28))
        player:updateEvent(slip, 1, odds, odds, 0, 0, race.weather, counter.color)
    elseif op == counterOp.LEAVE then
        -- "Only <minutes> remaining to place your chocobets!", or the last call under a minute.
        player:updateEvent(math.floor(closesIn / 60), closesIn % 60, 0, 0, 0, 0, race.weather, counter.color)
    end

    -- Early return: the rest is the purchase.
    if op ~= counterOp.BUY then
        return
    end

    local cost = quills * betting.QUILL_PRICE

    -- Capture needed
    -- The counter's answer to a bet it cannot take.
    if
        not validPair or
        quills < 1 or
        quills > betting.MAX_QUILLS or
        player:getGil() < cost
    then
        player:updateEvent(xi.chocoboRacing.buyResult.ERROR, quills, cost, 0, 0, 0, race.weather, counter.color)

        return
    end

    local ticket = player:addItem({ id = xi.item.CHOCOBET_TICKET, silent = true })

    -- Retail answers a full inventory with the ticket's item id, and the counter says nothing more.
    if not ticket then
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.CHOCOBET_TICKET)
        player:updateEvent(xi.item.CHOCOBET_TICKET, quills, cost, 0, 0, 0, race.weather, counter.color)

        return
    end

    -- TODO: Retail fills the 22 bits after the quills with a value that differs per race.
    ticket:setExData({
        raceId       = xi.chocoboRacing.shownRaceNo(race.raceNo),
        raceGrade    = xi.chocoboRacing.getRaceGrade(race.raceNo),
        racePairingL = math.min(laneA, laneB),
        racePairingR = math.max(laneA, laneB),
        quills       = quills,
    })

    player:delGil(cost)
    player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.CHOCOBET_TICKET)

    local pair = pairOf(laneA, laneB)
    local pool = getPool(race.raceNo)
    pool[pair] = pool[pair] + quills
    AddChocoboRaceQuills(race.raceNo, pair - 1, quills)

    if not player:hasKeyItem(xi.keyItem.CHOCOBO_CIRCUIT_GRANDSTAND_PASS) then
        npcUtil.giveKeyItem(player, xi.keyItem.CHOCOBO_CIRCUIT_GRANDSTAND_PASS)
    end

    player:updateEvent(xi.chocoboRacing.buyResult.SOLD, quills, cost, 0, 0, 0, race.weather, counter.color)
end

---@param player CBaseEntity
---@param csid integer
---@param option integer
---@param npc CBaseEntity
xi.chocoboRacing.onCounterEventFinish = function(player, csid, option, npc)
    -- Early return: not the ticket event.
    if csid ~= counterOf(npc).ticket then
        return
    end

    local ticket = readTicket(player:getTrade())

    -- Early return: no ticket in the trade.
    if not ticket then
        return
    end

    if
        option == xi.chocoboRacing.ticketOption.COLLECT and
        ticket.status == xi.chocoboRacing.ticketStatus.WINNER
    then
        if player:confirmTrade() then
            player:addGil(ticket.payout * ticket.quills)
            player:messageSpecial(zones[xi.zone.CHOCOBO_CIRCUIT].text.GIL_OBTAINED, ticket.payout * ticket.quills)
        end
    elseif
        option == xi.chocoboRacing.ticketOption.DISPOSE and
        (ticket.status == xi.chocoboRacing.ticketStatus.LOSER or ticket.status == xi.chocoboRacing.ticketStatus.EXPIRED)
    then
        player:confirmTrade()
    end
end
