local utils = require('scripts/tests/utils')

-- Not an actual test, showcases how to mock a function
describe('xi.effects.protect', function()
    local client, player

    local fakeEffectGain = function(target, effect)
        target:addMod(xi.mod.DEF, 666)
    end

    before_each(function()
        client, player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        player:changeJob(xi.job.WHM)
        player:setLevel(99)
        player:addSpell(xi.magic.spell.PROTECT)
    end)

    it('can be mocked to grant 666 DEF', function()
        local existingDef = player:getStat(xi.mod.DEF)
        utils.mock(xi.effects.protect, 'onEffectGain', fakeEffectGain, function(mockedFn)
            -- This sends an actual spellcast packet
            client:useSpell(player, xi.magic.spell.PROTECT)

            -- Wait for the spell to finish casting
            xi.test.world:skipTime(3)

            assert.is.equal(existingDef + 666, player:getStat(xi.mod.DEF))
            mockedFn.was.called()
        end)
    end)
end)
