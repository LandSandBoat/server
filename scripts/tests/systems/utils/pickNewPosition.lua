local romaeveID = zones[xi.zone.ROMAEVE]

describe('npcUtil.pickNewPosition()', function()
    local positions = romaeveID.npc.BASTOK_7_1_QM_POS

    before_each(function()
        local player = xi.test.world:spawnPlayer()
        player:gotoZone(xi.zone.ROMAEVE)

        local qm = GetNPCByID(romaeveID.npc.BASTOK_7_1_QM)
        assert(qm, 'Expected the Bastok 7-1 ???')
        qm:setPos(positions[1][1], positions[1][2], positions[1][3])
    end)

    it('moves off the current position even when every roll is the lowest', function()
        stub('math.randomInt', function(lower, upper)
            return lower
        end)

        local newPosition = npcUtil.pickNewPosition(romaeveID.npc.BASTOK_7_1_QM, positions)
        assert(newPosition.x == positions[2][1] and newPosition.z == positions[2][3], 'Expected the next position over')
    end)

    it('can pick the last position when the current one is allowed', function()
        stub('math.randomInt', function(lower, upper)
            return upper
        end)

        local newPosition = npcUtil.pickNewPosition(romaeveID.npc.BASTOK_7_1_QM, positions, true)
        assert(newPosition.x == positions[#positions][1] and newPosition.z == positions[#positions][3], 'Expected the last position')
    end)
end)
