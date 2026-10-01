describe('Deaggro', function()
    -- CLuaBaseEntity::getCurrentAction() value
    local actionMagicCasting = 30

    ---@type CClientEntityPair
    local puller

    ---@type CClientEntityPair
    local other

    ---@type CTestEntity
    local mob

    before_each(function()
        puller = xi.test.world:spawnPlayer({ zone = xi.zone.THE_ELDIEME_NECROPOLIS })
        other  = xi.test.world:spawnPlayer({ zone = xi.zone.THE_ELDIEME_NECROPOLIS })
        mob    = puller.entities:moveTo('Lich')
        mob:respawn()
        puller:setUnkillable(true)
        other:setUnkillable(true)
    end)

    -- the puller stays out of hearing range
    local function wait(steps)
        for _ = 1, steps do
            puller:setPos(mob:getXPos() + 15, mob:getYPos(), mob:getZPos())
            xi.test.world:skipTime(1)
            xi.test.world:tickEntity(mob)
        end
    end

    it('drops its cast and engages whoever acts next', function()
        mob:setMagicCastingEnabled(false)
        mob:addEnmity(puller, 100, 100)
        wait(16)

        mob:setMagicCastingEnabled(true)
        mob:castSpell(xi.magic.spell.FREEZE, puller)
        wait(4)

        assert(not mob:isEngaged())
        assert(mob:getCurrentAction() ~= actionMagicCasting)

        other:setPos(mob:getXPos(), mob:getYPos(), mob:getZPos())
        mob:addEnmity(other, 1, 320)
        wait(1)

        assert(mob:isEngaged())
    end)
end)
