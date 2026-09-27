-----------------------------------
-- Chocobo Raising - Eggs, colour genes, chococards and breeding
-----------------------------------
require('scripts/globals/hobbies/chocobo_raising/constants')
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}
xi.chocoboRaising.breeding = xi.chocoboRaising.breeding or {}

-----------------------------------
-- Constants
-----------------------------------
local color = xi.chocoboRaising.color
local plans = xi.chocoboRaising.honeymoonPlan

-- Finbarr (Upper Jeuno), VCS Honeymoon
local breeding = xi.chocoboRaising.breeding

-- Points a bred egg adds to its plan's stat at hatching.
local planStatSeed = 8

xi.chocoboRaising.chococardPrice = 300

-- Guess: percent chance per gene.
local mutationChance = 5

local ticketPrice = 3500

-- The laid egg waits until the JST midnight after the date.
breeding.eggItemVar  = '[ChocoboBreeding]EggItem'
breeding.eggGenesVar = '[ChocoboBreeding]EggGenes'
breeding.eggReadyVar = '[ChocoboBreeding]EggReady'

-----------------------------------
-- Tables
-----------------------------------
-- Gene order for the odds in eggGenetics.
local allColors = { color.YELLOW, color.BLACK, color.BLUE, color.RED, color.GREEN }

-- Percent odds: colors in allColors order; pattern for three, two or no matching genes.
local eggGenetics =
{
    [xi.item.CHOCOBO_EGG_FAINTLY_WARM ] = { colors = { 95,  3,  1,   0.5, 0.5 }, pattern = { 25,   50, 25   } },
    [xi.item.CHOCOBO_EGG_SLIGHTLY_WARM] = { colors = { 85,  5,  3.4, 3.3, 3.3 }, pattern = { 17.5, 60, 22.5 } },
    [xi.item.CHOCOBO_EGG_A_BIT_WARM   ] = { colors = { 75, 10,  5,   5,   5   }, pattern = { 16,   65, 19   } },
    [xi.item.CHOCOBO_EGG_A_LITTLE_WARM] = { colors = { 32, 18, 18,  16,  16   }, pattern = { 15,   70, 15   } },
    [xi.item.CHOCOBO_EGG_SOMEWHAT_WARM] = { colors = { 12, 22, 22,  22,  22   }, pattern = { 10,   75, 15   } },
}

-- Guess: percent chance of a male; other plans are even.
local planMaleChance =
{
    [plans.GOURMET] = 70,
    [plans.HIKING ] = 30,
}

-- The stat each plan's egg is seeded with.
local planStat =
{
    [plans.GOURMET   ] = 'strength',
    [plans.SPORTS    ] = 'endurance',
    [plans.HIKING    ] = 'discernment',
    [plans.JEUNO_TOUR] = 'receptivity',
}

-- Card jockey size for the owner's race.
local jockeySizes =
{
    [xi.race.HUME_M  ] = xi.chocoboRacing.jockeySize.HUME_M,
    [xi.race.HUME_F  ] = xi.chocoboRacing.jockeySize.HUME_F,
    [xi.race.ELVAAN_M] = xi.chocoboRacing.jockeySize.ELVAAN_M,
    [xi.race.ELVAAN_F] = xi.chocoboRacing.jockeySize.ELVAAN_F,
    [xi.race.TARU_M  ] = xi.chocoboRacing.jockeySize.TARUTARU_M,
    [xi.race.TARU_F  ] = xi.chocoboRacing.jockeySize.TARUTARU_F,
    [xi.race.MITHRA  ] = xi.chocoboRacing.jockeySize.MITHRA,
    [xi.race.GALKA   ] = xi.chocoboRacing.jockeySize.GALKA,
}

-- The egg each plan lays. Sports and Hiking are guesses.
local bredEggItem =
{
    [plans.GOURMET   ] = xi.item.CHOCOBO_EGG_SOMEWHAT_WARM,
    [plans.SPORTS    ] = xi.item.CHOCOBO_EGG_A_LITTLE_WARM,
    [plans.HIKING    ] = xi.item.CHOCOBO_EGG_A_LITTLE_WARM,
    [plans.JEUNO_TOUR] = xi.item.CHOCOBO_EGG_A_BIT_WARM,
}

---@enum honeymoonEvent
local event =
{
    DATE          = 10102,
    FIRST_MEETING = 10103,
    WAITING       = 10105,
    EGG_LAID      = 10107,
    TICKET_MENU   = 10108,
}

-- What each item in the date trade stands for.
local dateItemRole =
{
    [xi.item.VCS_HONEYMOON_TICKET] = 'ticket',
    [xi.item.CHOCOCARD_M         ] = 'sire',
    [xi.item.CHOCOCARD_F         ] = 'dam',
}

-----------------------------------
-- Specs
-----------------------------------
---@class ChocoboPendingEgg
---@field itemId integer
---@field exdata ExdataChocoboEgg
---@field ready  boolean

-----------------------------------
-- Helpers
-----------------------------------
local function weightedPick(weights)
    local total = 0
    for _, weight in ipairs(weights) do
        total = total + weight
    end

    local roll = math.randomInt(1, 1000) * total / 1000
    for index, weight in ipairs(weights) do
        roll = roll - weight
        if roll <= 0 then
            return index
        end
    end

    return #weights
end

-- nil for an unbred egg, whose exdata is all zeroes.
local function bredExdata(egg)
    if not egg then
        return nil
    end

    local exdata = egg:getExData()
    if exdata and exdata.isBred then
        return exdata
    end

    return nil
end

-- Card stat byte: rank in bits 5-7, rank points in 1-4, and for STR, END and DSC the feature in bit 0.
local function statByte(value, trait)
    return
    {
        trait = trait,
        rp    = bit.band(bit.rshift(value, 1), 0xF),
        rank  = bit.rshift(value, 5),
    }
end

local function cardAbilities(card)
    local abilities = {}
    for _, ability in ipairs(card.abilities or {}) do
        if ability ~= xi.chocoboRaising.ability.NONE then
            table.insert(abilities, ability)
        end
    end

    return abilities
end

-- Exdata word: genes in bits 0-8, ability in 9-12, plan in 14-15.
local function packEgg(egg)
    return egg.dna[1] + bit.lshift(egg.dna[2], 3) + bit.lshift(egg.dna[3], 6) +
        bit.lshift(egg.ability, 9) + bit.lshift(egg.plan, 14)
end

local function unpackEgg(word)
    return
    {
        dna     = { bit.band(word, 7), bit.band(bit.rshift(word, 3), 7), bit.band(bit.rshift(word, 6), 7) },
        ability = bit.band(bit.rshift(word, 9), 0xF),
        plan    = bit.band(bit.rshift(word, 14), 3),
        isBred  = true,
    }
end

-- Look for event 10102: colour in bits 9-11; bit 12 marks the male.
local function dateLook(card, isSire)
    local look = bit.lshift(card.color or color.YELLOW, 9)
    if isSire then
        look = look + 0x1000
    end

    return look
end

local function dateItems(trade)
    local items = {}

    for slot = 0, 7 do
        local item = trade:getItem(slot)
        if item then
            local role = dateItemRole[item:getID()]
            if role then
                items[role] = item
            end
        end
    end

    return items
end

-----------------------------------
-- Private Functions
-----------------------------------
local function inheritDNA(sireDNA, damDNA)
    local dna = {}
    for i = 1, 3 do
        local gene = sireDNA[i] or color.YELLOW
        if math.randomInt(1, 2) == 2 then
            gene = damDNA[i] or color.YELLOW
        end

        if math.randomInt(1, 100) <= mutationChance then
            gene = allColors[math.randomInt(1, #allColors)]
        end

        dna[i] = gene
    end

    return dna
end

local function inheritAbility(sire, dam, plan)
    local sireAbilities = cardAbilities(sire)
    local damAbilities  = cardAbilities(dam)

    if #sireAbilities + #damAbilities == 0 then
        return xi.chocoboRaising.ability.NONE
    end

    -- Guess: 60% plus 3 per receptivity rank.
    local receptivityRank = (bit.rshift(xi.chocoboRaising.cardReceptivity(sire), 5) + bit.rshift(xi.chocoboRaising.cardReceptivity(dam), 5)) / 2
    if math.randomInt(1, 100) > 60 + math.floor(receptivityRank * 3) then
        return xi.chocoboRaising.ability.NONE
    end

    -- Guess: Sports leans to the sire's abilities and Jeuno Tour to the dam's.
    local favoured
    if plan == plans.SPORTS then
        favoured = sireAbilities
    elseif plan == plans.JEUNO_TOUR then
        favoured = damAbilities
    end

    if
        favoured and
        #favoured > 0 and
        math.randomInt(1, 100) <= 70
    then
        return favoured[math.randomInt(1, #favoured)]
    end

    local pool = {}
    for _, ability in ipairs(sireAbilities) do
        table.insert(pool, ability)
    end

    for _, ability in ipairs(damAbilities) do
        table.insert(pool, ability)
    end

    return pool[math.randomInt(1, #pool)]
end

local function finishDate(player)
    local items = dateItems(player:getTrade())
    if
        not items.ticket or
        not items.sire or
        not items.dam
    then
        return
    end

    local plan   = items.ticket:getExData().plan or plans.GOURMET
    local egg    = xi.chocoboRaising.breedEgg(items.sire:getExData(), items.dam:getExData(), plan)
    local itemId = bredEggItem[plan] or xi.item.CHOCOBO_EGG_SOMEWHAT_WARM

    if not player:confirmTrade() then
        return
    end

    player:setCharVar(breeding.eggItemVar, itemId)
    player:setCharVar(breeding.eggGenesVar, packEgg(egg))
    player:setCharVar(breeding.eggReadyVar, JstMidnight())
end

-- TODO: Missing the reply for a full inventory; the egg waits.
local function giveEgg(player)
    local egg = breeding.pendingEgg(player)
    if not egg then
        return
    end

    local ID = zones[player:getZoneID()]

    if player:getFreeSlotsCount() == 0 then
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, egg.itemId)
        return
    end

    player:addItem({ id = egg.itemId, exdata = egg.exdata })
    player:messageSpecial(ID.text.YOU_OBTAIN_ITEM, 0, egg.itemId)

    player:setCharVar(breeding.eggItemVar, 0)
    player:setCharVar(breeding.eggGenesVar, 0)
    player:setCharVar(breeding.eggReadyVar, 0)
end

-- Finish options 1 to 4 buy the Gourmet, Sports, Hiking or Jeuno Tour ticket; 10 buys nothing.
local function buyTicket(player, npc, plan)
    local ID = zones[player:getZoneID()]

    if player:getGil() < ticketPrice then
        player:messageSpecial(ID.text.NOT_HAVE_ENOUGH_GIL)
        return
    end

    -- The ticket is Rare.
    if
        player:getFreeSlotsCount() == 0 or
        player:hasItem(xi.item.VCS_HONEYMOON_TICKET)
    then
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.VCS_HONEYMOON_TICKET)
        return
    end

    player:delGil(ticketPrice)
    player:addItem({ id = xi.item.VCS_HONEYMOON_TICKET, exdata = { plan = plan } })
    player:showText(npc, ID.text.FINBARR_TRADE_TICKET_AND_CARDS)
    player:messageSpecial(ID.text.YOU_OBTAIN_ITEM, 0, xi.item.VCS_HONEYMOON_TICKET)
end

-----------------------------------
-- Global Functions
-----------------------------------
---@param dna xi.chocoboRaising.color[]
---@return xi.chocoboRaising.color
xi.chocoboRaising.allelesToColor = function(dna)
    local counts = {}
    for i = 1, 3 do
        local gene = dna[i] or color.YELLOW
        counts[gene] = (counts[gene] or 0) + 1
    end

    for gene, count in pairs(counts) do
        if count >= 2 then
            return gene
        end
    end

    if counts[color.YELLOW] or not counts[color.BLACK] then
        return color.YELLOW
    end

    return color.BLACK
end

-- Three different genes show only yellow or black, so other colours fall back to two matching genes.
---@param itemId integer
---@return xi.chocoboRaising.color[]
xi.chocoboRaising.rollNonBredEggAlleles = function(itemId)
    local genetics = eggGenetics[itemId] or eggGenetics[xi.item.CHOCOBO_EGG_FAINTLY_WARM]
    local shown    = allColors[weightedPick(genetics.colors)]
    local pattern  = weightedPick(genetics.pattern)

    if pattern == 1 then
        return { shown, shown, shown }
    end

    if
        pattern == 3 and
        (shown == color.YELLOW or shown == color.BLACK)
    then
        local genes = { shown }
        while #genes < 3 do
            local gene = allColors[math.randomInt(1, #allColors)]

            -- A black egg must not carry yellow, or it would show yellow.
            local allowed = gene ~= shown and not (shown == color.BLACK and gene == color.YELLOW)
            for _, existing in ipairs(genes) do
                allowed = allowed and gene ~= existing
            end

            if allowed then
                table.insert(genes, gene)
            end
        end

        return genes
    end

    local others = {}
    for _, gene in ipairs(allColors) do
        if gene ~= shown then
            table.insert(others, gene)
        end
    end

    local genes = { shown, shown, others[math.randomInt(1, #others)] }
    local odd   = math.randomInt(1, 3)

    genes[3], genes[odd] = genes[odd], genes[3]

    return genes
end

---@param egg CItem?
---@return xi.chocoboRaising.color[]
xi.chocoboRaising.rollEggAlleles = function(egg)
    local exdata = bredExdata(egg)
    if exdata and exdata.dna then
        return { exdata.dna[1], exdata.dna[2], exdata.dna[3] }
    end

    return xi.chocoboRaising.rollNonBredEggAlleles(egg and egg:getID() or 0)
end

-- The egg stores the plan 0-based; the ticket and the enum are 1-based.
---@param egg CItem?
---@return xi.chocoboRaising.honeymoonPlan?
xi.chocoboRaising.eggPlan = function(egg)
    local exdata = bredExdata(egg)
    if exdata then
        return (exdata.plan or 0) + 1
    end

    return nil
end

---@param egg CItem?
---@return xi.chocoboRaising.gender
xi.chocoboRaising.rollEggGender = function(egg)
    local chance = planMaleChance[xi.chocoboRaising.eggPlan(egg)] or 50

    if math.randomInt(1, 100) <= chance then
        return xi.chocoboRaising.gender.MALE
    end

    return xi.chocoboRaising.gender.FEMALE
end

---@param egg CItem?
---@return xi.chocoboRaising.ability
xi.chocoboRaising.rollEggInheritedAbility = function(egg)
    local exdata = bredExdata(egg)
    if exdata and exdata.ability then
        return exdata.ability
    end

    return xi.chocoboRaising.ability.NONE
end

---@param chocoState table
---@param egg CItem?
---@return nil
xi.chocoboRaising.seedEggStats = function(chocoState, egg)
    local field = planStat[xi.chocoboRaising.eggPlan(egg)]
    if field then
        chocoState[field] = chocoState[field] + planStatSeed
    end
end

---@param player CBaseEntity
---@param chocoState table
---@return ExdataChocoboCard
xi.chocoboRaising.chocoStateToCard = function(player, chocoState)
    local appearance = chocoState.appearance or 0
    local fullName   = xi.chocoboRaising.nameStrings(chocoState)

    return
    {
        strength    = statByte(chocoState.strength, bit.band(appearance, xi.chocoboRaising.appearance.LARGE_TALONS) ~= 0),
        endurance   = statByte(chocoState.endurance, bit.band(appearance, xi.chocoboRaising.appearance.FULL_TAIL) ~= 0),
        discernment = statByte(chocoState.discernment, bit.band(appearance, xi.chocoboRaising.appearance.LARGE_BEAK) ~= 0),
        receptivity = { rp = bit.band(chocoState.receptivity, 0x1F), rank = bit.rshift(chocoState.receptivity, 5) },
        dna         = { chocoState.allele1, chocoState.allele2, chocoState.allele3 },
        abilities   = { chocoState.ability1, chocoState.ability2 },
        temperament = chocoState.personality,
        weather     = chocoState.weather_preference,
        gender      = chocoState.sex,
        color       = chocoState.color,
        size        = jockeySizes[player:getRace()] or xi.chocoboRacing.jockeySize.HUME_M,
        name        = fullName,
    }
end

-- The "Request documentation" menu, finish option 239.
---@param player CBaseEntity
---@param chocoState table
---@return boolean
xi.chocoboRaising.issueChococard = function(player, chocoState)
    if
        chocoState.stage < xi.chocoboRaising.stage.ADULT_1 or
        not xi.chocoboRaising.isNamed(chocoState)
    then
        return false
    end

    local ID     = zones[player:getZoneID()]
    local itemId = chocoState.sex == xi.chocoboRaising.gender.FEMALE and xi.item.CHOCOCARD_F or xi.item.CHOCOCARD_M

    if player:getGil() < xi.chocoboRaising.chococardPrice then
        player:messageSpecial(ID.text.NOT_HAVE_ENOUGH_GIL)
        return false
    end

    if player:getFreeSlotsCount() == 0 then
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, itemId)
        return false
    end

    player:delGil(xi.chocoboRaising.chococardPrice)
    player:addItem({ id = itemId, exdata = xi.chocoboRaising.chocoStateToCard(player, chocoState) })
    player:messageSpecial(ID.text.ITEM_OBTAINED, itemId)

    return true
end

-- Receptivity from a card, back on the 0-255 scale.
---@param card ExdataChocoboCard
---@return integer
xi.chocoboRaising.cardReceptivity = function(card)
    if not card.receptivity then
        return 0
    end

    return bit.lshift(card.receptivity.rank or 0, 5) + (card.receptivity.rp or 0)
end

---@param card ExdataChocoboCard
---@param field 'strength'|'endurance'|'discernment'|'receptivity'
---@return integer
xi.chocoboRaising.cardStat = function(card, field)
    if field == 'receptivity' then
        return xi.chocoboRaising.cardReceptivity(card)
    end

    if not card[field] then
        return 0
    end

    return bit.lshift(card[field].rank or 0, 5) + bit.lshift(card[field].rp or 0, 1)
end

-- The egg stores the plan 0-based.
---@param sire ExdataChocoboCard
---@param dam ExdataChocoboCard
---@param plan xi.chocoboRaising.honeymoonPlan
---@return ExdataChocoboEgg
xi.chocoboRaising.breedEgg = function(sire, dam, plan)
    return
    {
        dna     = inheritDNA(sire.dna or {}, dam.dna or {}),
        ability = inheritAbility(sire, dam, plan),
        plan    = plan - 1,
        isBred  = true,
    }
end

---@param player CBaseEntity
---@return ChocoboPendingEgg?
breeding.pendingEgg = function(player)
    local itemId = player:getCharVar(breeding.eggItemVar)
    if itemId == 0 then
        return nil
    end

    return
    {
        itemId = itemId,
        exdata = unpackEgg(player:getCharVar(breeding.eggGenesVar)),
        ready  = GetSystemTime() >= player:getCharVar(breeding.eggReadyVar),
    }
end

---@param player CBaseEntity
---@param npc CBaseEntity
---@return nil
breeding.onTrigger = function(player, npc)
    local egg = breeding.pendingEgg(player)

    if egg and egg.ready then
        player:startEvent(event.EGG_LAID)
    elseif egg then
        player:startEvent(event.WAITING)
    else
        player:startEvent(event.TICKET_MENU)
    end
end

---@param player CBaseEntity
---@param npc CBaseEntity
---@param trade CTradeContainer
---@return nil
breeding.onTrade = function(player, npc, trade)
    if breeding.pendingEgg(player) then
        player:startEvent(event.WAITING)
        return
    end

    if not npcUtil.tradeHasExactly(trade, { xi.item.VCS_HONEYMOON_TICKET, xi.item.CHOCOCARD_M, xi.item.CHOCOCARD_F }) then
        return
    end

    local items = dateItems(trade)
    local plan  = items.ticket:getExData().plan or plans.GOURMET

    player:startEvent(event.DATE, plan, dateLook(items.sire:getExData(), true), dateLook(items.dam:getExData(), false))
end

---@param player CBaseEntity
---@param csid integer
---@param option integer
---@param npc CBaseEntity
---@return nil
breeding.onEventFinish = function(player, csid, option, npc)
    if
        csid == event.TICKET_MENU and
        option >= plans.GOURMET and
        option <= plans.JEUNO_TOUR
    then
        buyTicket(player, npc, option)
    elseif csid == event.DATE then
        finishDate(player)
    elseif csid == event.EGG_LAID then
        giveEgg(player)
    end
end
