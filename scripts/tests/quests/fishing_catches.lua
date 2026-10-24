-- Zone-wide quest catches ignore the fishing area
local anyArea = 1

-- Flattens onFishingCheck answers the same way luautils::OnFishingCheck does
local function offeredCatches(player, areaId)
    local catches = {}
    for _, answer in ipairs(InteractionGlobal.onFishingCheck(player, areaId)) do
        for _, catchId in ipairs(answer) do
            catches[catchId] = true
        end
    end

    return catches
end

describe('Quest fishing catches', function()
    it('offers the Ripped Cap in Port Windurst until the angler holds one', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.PORT_WINDURST })
        assert(offeredCatches(player, anyArea)[xi.item.RIPPED_CAP], 'Ripped Cap was not offered')

        player:addItem(xi.item.RIPPED_CAP)
        assert(not offeredCatches(player, anyArea)[xi.item.RIPPED_CAP], 'Ripped Cap was offered to an angler holding one')
    end)

    it('offers the Hydrogauge only while Navigating the Unfriendly Seas is accepted', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.NASHMAU })
        assert(not offeredCatches(player, anyArea)[xi.item.HYDROGAUGE], 'Hydrogauge was offered before the quest')

        player:addQuest(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS)
        assert(offeredCatches(player, anyArea)[xi.item.HYDROGAUGE], 'Hydrogauge was not offered during the quest')
    end)

    it('offers the Damp Scroll only in the pond under the bridge until Secret of the Damp Scroll is done', function()
        local pond   = 2
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.SEA_SERPENT_GROTTO })
        assert(offeredCatches(player, pond)[xi.item.DAMP_SCROLL], 'Damp Scroll was not offered in the pond')
        assert(not offeredCatches(player, 1)[xi.item.DAMP_SCROLL], 'Damp Scroll was offered outside the pond')

        player:addItem(xi.item.DAMP_SCROLL)
        assert(not offeredCatches(player, pond)[xi.item.DAMP_SCROLL], 'Damp Scroll was offered to an angler holding one')

        player:delItem(xi.item.DAMP_SCROLL, 1)
        player:completeQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.SECRET_OF_THE_DAMP_SCROLL)
        assert(not offeredCatches(player, pond)[xi.item.DAMP_SCROLL], 'Damp Scroll was offered after the quest')
    end)

    it('offers both fished Krakens only while Hook, Line, and Sinker is accepted', function()
        local qufimID = zones[xi.zone.QUFIM_ISLAND]
        local player  = xi.test.world:spawnPlayer({ zone = xi.zone.QUFIM_ISLAND })
        local krakens = qufimID.mob.KRAKEN_FISHED_NM

        assert(#krakens == 2, 'expected two fished Krakens in Qufim Island')
        for _, krakenId in ipairs(krakens) do
            assert(krakenId ~= qufimID.mob.KRAKEN_NM, 'the roaming Kraken was listed as a fished one')
            assert(not offeredCatches(player, anyArea)[krakenId], 'a Kraken was offered before the quest')
        end

        player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.HOOK_LINE_AND_SINKER)
        for _, krakenId in ipairs(krakens) do
            assert(offeredCatches(player, anyArea)[krakenId], 'a Kraken was not offered during the quest')
        end

        player:completeQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.HOOK_LINE_AND_SINKER)
        for _, krakenId in ipairs(krakens) do
            assert(not offeredCatches(player, anyArea)[krakenId], 'a Kraken was offered after the quest')
        end
    end)
end)
