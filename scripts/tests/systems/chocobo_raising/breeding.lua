-----------------------------------
-- Colour genes, eggs, chococards and breeding at Finbarr.
-----------------------------------
local raisingClient = require('scripts.tests.systems.chocobo_raising.client')
local helpers       = require('scripts.tests.systems.chocobo_raising.helpers')

local color = xi.chocoboRaising.color
local plans = xi.chocoboRaising.honeymoonPlan

local finbarr =
{
    DATE        = 10102,
    WAITING     = 10105,
    EGG_LAID    = 10107,
    TICKET_MENU = 10108,
}

local function rawBytes(item, count)
    local raw   = item:getExDataRaw()
    local bytes = {}
    for i = 0, count - 1 do
        bytes[i + 1] = raw[i] or 0
    end

    return bytes
end

local function assertBytes(label, actual, expected)
    for index, byte in ipairs(expected) do
        assert(actual[index] == byte, string.format('%s: byte %d is 0x%02X, captured 0x%02X', label, index - 1, actual[index], byte))
    end
end

local irisAudace =
{
    first_name         = 'Iris',
    last_name          = 'Audace',
    strength           = 56,
    endurance          = 48,
    discernment        = 8,
    receptivity        = 11,
    allele1            = color.YELLOW,
    allele2            = color.BLACK,
    allele3            = color.BLUE,
    ability1           = 0,
    ability2           = 0,
    personality        = xi.chocoboRaising.temperament.ENIGMATIC,
    weather_preference = 0,
    sex                = xi.chocoboRaising.gender.FEMALE,
    color              = color.YELLOW,
    appearance         = 0,
}

describe('Chocobo breeding', function()
    describe('genes', function()
        it('shows the colour of each gene set, and rolls mostly yellow from a Faintly Warm egg only', function()
            xi.test.world:setSeed(1)

            local cases =
            {
                { { color.YELLOW, color.BLACK,  color.BLUE   }, color.YELLOW },
                { { color.BLACK,  color.BLACK,  color.BLUE   }, color.BLACK  },
                { { color.YELLOW, color.YELLOW, color.GREEN  }, color.YELLOW },
                { { color.RED,    color.RED,    color.YELLOW }, color.RED    },
                { { color.BLACK,  color.RED,    color.GREEN  }, color.BLACK  },
                { { color.RED,    color.GREEN,  color.BLUE   }, color.YELLOW },
            }

            for _, case in ipairs(cases) do
                local shown = xi.chocoboRaising.allelesToColor(case[1])
                assert(shown == case[2], string.format('Genes %d %d %d: expected colour %d, got %d', case[1][1], case[1][2], case[1][3], case[2], shown))
            end

            local yellowShare = {}
            for _, itemId in ipairs({ xi.item.CHOCOBO_EGG_FAINTLY_WARM, xi.item.CHOCOBO_EGG_SOMEWHAT_WARM }) do
                local yellow = 0
                for _ = 1, 400 do
                    if xi.chocoboRaising.allelesToColor(xi.chocoboRaising.rollNonBredEggAlleles(itemId)) == color.YELLOW then
                        yellow = yellow + 1
                    end
                end

                yellowShare[itemId] = yellow / 400
            end

            -- The true odds are 95% and 12% yellow.
            assert(yellowShare[xi.item.CHOCOBO_EGG_FAINTLY_WARM] > 0.85, 'Expected a Faintly Warm egg to be mostly yellow')
            assert(yellowShare[xi.item.CHOCOBO_EGG_SOMEWHAT_WARM] < 0.3, 'Expected a Somewhat Warm egg to be mostly coloured')
        end)
    end)

    describe('breeding rules', function()
        local ability = xi.chocoboRaising.ability
        local sire    = { dna = { color.BLACK, color.BLACK, color.BLUE }, abilities = { ability.GALLOP, 0 } }
        local dam     = { dna = { color.YELLOW, color.BLACK, color.BLUE }, abilities = { ability.BURROW, 0 } }

        -- Real rolls, enough that an outcome with a 1% chance all but surely shows.
        local function breedMany(plan)
            local eggs = {}
            for i = 1, 10000 do
                eggs[i] = xi.chocoboRaising.breedEgg(sire, dam, plan)
            end

            return eggs
        end

        it('rolls every colour in every gene slot and stores the plan 0-based', function()
            local seen = { {}, {}, {} }
            for _, egg in ipairs(breedMany(plans.GOURMET)) do
                assert(egg.isBred, 'Expected a bred egg')

                for slot, gene in ipairs(egg.dna) do
                    seen[slot][gene] = true
                end
            end

            for slot = 1, 3 do
                for _, gene in ipairs({ color.YELLOW, color.BLACK, color.BLUE, color.RED, color.GREEN }) do
                    assert(seen[slot][gene], string.format('Expected colour %d in gene slot %d', gene, slot))
                end
            end

            assert(xi.chocoboRaising.breedEgg(sire, dam, plans.GOURMET).plan == 0, 'Expected Gourmet as 0')
            assert(xi.chocoboRaising.breedEgg(sire, dam, plans.JEUNO_TOUR).plan == 3, 'Expected Jeuno Tour as 3')
        end)

        it('passes on a parent\'s ability, leaning to the father on Sports and the mother on Jeuno Tour', function()
            local counts = {}
            for _, plan in ipairs({ plans.SPORTS, plans.JEUNO_TOUR }) do
                counts[plan] = { [ability.NONE] = 0, [ability.GALLOP] = 0, [ability.BURROW] = 0 }
                for _, egg in ipairs(breedMany(plan)) do
                    counts[plan][egg.ability] = counts[plan][egg.ability] + 1
                end

                assert(counts[plan][ability.NONE] > 0, string.format('Plan %d: expected some eggs to inherit no ability', plan))
                assert(counts[plan][ability.GALLOP] > 0, string.format('Plan %d: expected some eggs to inherit the father\'s ability', plan))
                assert(counts[plan][ability.BURROW] > 0, string.format('Plan %d: expected some eggs to inherit the mother\'s ability', plan))
            end

            local sports = counts[plans.SPORTS]
            local jeuno  = counts[plans.JEUNO_TOUR]
            assert(sports[ability.GALLOP] > sports[ability.BURROW], 'Expected Sports to favour the father')
            assert(jeuno[ability.BURROW] > jeuno[ability.GALLOP], 'Expected Jeuno Tour to favour the mother')

            local plain = { dna = { color.YELLOW, color.YELLOW, color.YELLOW }, abilities = { 0, 0 } }
            assert(xi.chocoboRaising.breedEgg(plain, plain, plans.SPORTS).ability == 0, 'Expected no ability when neither parent has one')
        end)
    end)

    it('writes eggs and cards like the captured items', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.UPPER_JEUNO, race = xi.race.HUME_M })

        local gourmet = player:addItem({ id = xi.item.CHOCOBO_EGG_SOMEWHAT_WARM, exdata = { dna = { 0, 1, 2 }, ability = 0, plan = 0, isBred = true } })
        assertBytes('Gourmet egg', rawBytes(gourmet, 4), { 0x88, 0x00, 0x00, 0x80 })

        local jeunoTour = player:addItem({ id = xi.item.CHOCOBO_EGG_A_BIT_WARM, exdata = { dna = { 4, 1, 2 }, ability = 0, plan = 3, isBred = true } })
        assertBytes('Jeuno Tour egg', rawBytes(jeunoTour, 4), { 0x8C, 0xC0, 0x00, 0x80 })

        local card = assert(player:addItem({ id = xi.item.CHOCOCARD_F, exdata = xi.chocoboRaising.chocoStateToCard(player, irisAudace) }))
        assertBytes('IrisAudace', rawBytes(card, 8), { 0x38, 0x30, 0x08, 0x0B, 0x88, 0x00, 0x08, 0x11 })
        assert(card:getExData().name == 'IrisAudace', 'Expected the name on the card')
    end)

    describe('at Finbarr', function()
        ---@type CClientEntityPair
        local player

        before_each(function()
            player = xi.test.world:spawnPlayer({ zone = xi.zone.UPPER_JEUNO })
        end)

        local function cardItem(itemId, dna, gender)
            local card = xi.chocoboRaising.chocoStateToCard(player,
            {
                first_name         = 'Test',
                last_name          = 'Bird',
                strength           = 0,
                endurance          = 0,
                discernment        = 0,
                receptivity        = 0,
                allele1            = dna[1],
                allele2            = dna[2],
                allele3            = dna[3],
                ability1           = 0,
                ability2           = 0,
                personality        = 0,
                weather_preference = 0,
                sex                = gender,
                color              = xi.chocoboRaising.allelesToColor(dna),
                appearance         = 0,
            })

            return player:addItem({ id = itemId, exdata = card })
        end

        it('sells one honeymoon ticket for 3500 gil', function()
            player:setGil(3499)
            player.entities:gotoAndTrigger('Finbarr', { eventId = finbarr.TICKET_MENU, finishOption = plans.GOURMET })

            player.assert:hasGil(3499)
            player.assert.no:hasItem(xi.item.VCS_HONEYMOON_TICKET)

            player:setGil(5000)
            player.entities:gotoAndTrigger('Finbarr', { eventId = finbarr.TICKET_MENU, finishOption = plans.GOURMET })

            player.assert:hasGil(1500)
            local ticket = player:findItem(xi.item.VCS_HONEYMOON_TICKET)
            assert(ticket and ticket:getExData().plan == plans.GOURMET, 'Expected a Gourmet ticket')

            -- The ticket is Rare, so a second one cannot be given.
            player:setGil(5000)
            player.entities:gotoAndTrigger('Finbarr', { eventId = finbarr.TICKET_MENU, finishOption = plans.SPORTS })

            player.assert:hasGil(5000)
            assert(player:getItemCount(xi.item.VCS_HONEYMOON_TICKET) == 1, 'Expected one ticket')
            assert(player:findItem(xi.item.VCS_HONEYMOON_TICKET):getExData().plan == plans.GOURMET, 'Expected the Gourmet ticket kept')
        end)

        it('keeps a ready egg for a full inventory until there is room', function()
            local breeding = xi.chocoboRaising.breeding
            player:setCharVar(breeding.eggItemVar, xi.item.CHOCOBO_EGG_SOMEWHAT_WARM)
            player:setCharVar(breeding.eggReadyVar, 1)
            raisingClient.leaveFreeSlots(player, 0)

            player.entities:gotoAndTrigger('Finbarr', { eventId = finbarr.EGG_LAID, finishOption = 0 })

            player.assert.no:hasItem(xi.item.CHOCOBO_EGG_SOMEWHAT_WARM)
            assert(breeding.pendingEgg(player), 'Expected the egg kept')

            raisingClient.leaveFreeSlots(player, 1)
            player.entities:gotoAndTrigger('Finbarr', { eventId = finbarr.EGG_LAID, finishOption = 0 })

            player.assert:hasItem(xi.item.CHOCOBO_EGG_SOMEWHAT_WARM)
            assert(not breeding.pendingEgg(player), 'Expected the egg collected')
        end)

        it('answers chococards without a ticket with the ticket menu', function()
            cardItem(xi.item.CHOCOCARD_M, { color.BLACK, color.BLACK, color.BLUE }, xi.chocoboRaising.gender.MALE)
            cardItem(xi.item.CHOCOCARD_F, { color.YELLOW, color.BLACK, color.BLUE }, xi.chocoboRaising.gender.FEMALE)

            player.actions:tradeNpc('Finbarr', { xi.item.CHOCOCARD_M, xi.item.CHOCOCARD_F })
            player.events:expect({ eventId = finbarr.TICKET_MENU, finishOption = 0 })
        end)

        it('lays an egg from the parents\' genes after JST midnight', function()
            stub('math.randomInt', helpers.lowestRoll)

            local client = raisingClient.forNPC(player, 'Finbarr', finbarr.DATE)

            player:addItem({ id = xi.item.VCS_HONEYMOON_TICKET, exdata = { plan = plans.GOURMET } })
            cardItem(xi.item.CHOCOCARD_M, { color.BLACK, color.BLACK, color.BLUE }, xi.chocoboRaising.gender.MALE)
            cardItem(xi.item.CHOCOCARD_F, { color.YELLOW, color.BLACK, color.BLUE }, xi.chocoboRaising.gender.FEMALE)

            local start = raisingClient.trade(client, { xi.item.VCS_HONEYMOON_TICKET, xi.item.CHOCOCARD_M, xi.item.CHOCOCARD_F })
            assert(start.eventId == finbarr.DATE, 'Expected the date')
            assert(start.params[0] == plans.GOURMET and start.params[1] == 4608 and start.params[2] == 0, 'Expected the captured params')
            raisingClient.finish(client, 0)

            player.assert.no:hasItem(xi.item.VCS_HONEYMOON_TICKET)
            player.assert.no:hasItem(xi.item.CHOCOCARD_M)
            player.assert.no:hasItem(xi.item.CHOCOCARD_F)

            player.entities:gotoAndTrigger('Finbarr', { eventId = finbarr.WAITING })

            xi.test.world:tick(xi.tick.JST_DAY)
            player.entities:gotoAndTrigger('Finbarr', { eventId = finbarr.EGG_LAID, finishOption = 0 })

            local egg = player:findItem(xi.item.CHOCOBO_EGG_SOMEWHAT_WARM)
            assert(egg, 'Expected the Gourmet egg')

            local exdata = egg:getExData()
            assert(exdata.isBred and exdata.plan == 0, 'Expected a bred Gourmet egg')
        end)
    end)

    describe('chococards from the trainer', function()
        ---@type CClientEntityPair
        local player

        before_each(function()
            xi.test.world:setSetting('main.ENABLE_CHOCOBO_RAISING', true)
            player = xi.test.world:spawnPlayer({ zone = xi.zone.SOUTHERN_SAN_DORIA })
            player:deleteRaisedChocobo()
        end)

        after_each(function()
            player:deleteRaisedChocobo()
        end)

        it('issues a chococard for a named adult only with 300 gil and a free slot', function()
            local client = raisingClient.tradeEgg(player)
            raisingClient.setChocobo(player,
            {
                first_name = 'Iris',
                last_name  = 'Audace',
                sex        = xi.chocoboRaising.gender.FEMALE,
                stage      = xi.chocoboRaising.stage.ADULT_1,
                strength   = 56,
            })

            player:setGil(299)
            raisingClient.talk(client)
            raisingClient.finish(client, xi.chocoboRaising.documentChococard)

            player.assert:hasGil(299)
            player.assert.no:hasItem(xi.item.CHOCOCARD_F)

            player:setGil(1000)
            raisingClient.leaveFreeSlots(player, 0)
            raisingClient.talk(client)
            raisingClient.finish(client, xi.chocoboRaising.documentChococard)

            player.assert:hasGil(1000)
            player.assert.no:hasItem(xi.item.CHOCOCARD_F)
            assert(player:getFreeSlotsCount() == 0, 'Expected the inventory unchanged')

            raisingClient.leaveFreeSlots(player, 1)
            raisingClient.talk(client)
            raisingClient.finish(client, xi.chocoboRaising.documentChococard)

            player.assert:hasGil(700)
            local card = player:findItem(xi.item.CHOCOCARD_F)
            assert(card and card:getExData().name == 'IrisAudace', 'Expected IrisAudace\'s card')
            assert(card:getExData().strength.rank == xi.chocoboRaising.statRank.SUBSTANDARD, 'Expected strength E on the card')
        end)
    end)
end)
