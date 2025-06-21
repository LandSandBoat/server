-- Not yet converted because claim shield is optional on LSB
---@type TestSuite
local suite = {}

suite['Claim shield blocks spell that is too fast, but allows long spell to claim.'] = function(world)
    local blmClient1, blm1 = world:spawnPlayer({ zone = xi.zone.Dragons_Aery })
    blm1:changeJob(xi.job.BLM)
    blm1:changesJob(xi.job.RDM)
    blm1:setLevel(75)
    blm1:setsLevel(37)
    blm1:addSpell(xi.spell.DIA, true)
    blm1:addStatusEffect(xi.effect.IMMORTAL, 0, 0, 0, 50001)
    blmClient1:useAbility(blm1, xi.jobAbility.MANAFONT)

    local blmClient2, blm2 = world:spawnPlayer({ zone = xi.zone.Dragons_Aery })
    blm2:changeJob(xi.job.BLM)
    blm2:changesJob(xi.job.RDM)
    blm2:setLevel(75)
    blm1:setsLevel(37)
    blm2:addSpell(xi.spell.FREEZE, true)
    blm2:addStatusEffect(xi.effect.IMMORTAL, 0, 0, 0, 50001)
    blmClient2:useAbility(blm2, xi.jobAbility.MANAFONT)

    local nidhogg = blmClient1:getEntity('Nidhogg')

    -- Ensure it is despawned initially
    DespawnMob(nidhogg:getID())
    world:skipTime(20)
    world:tick()
    assert(nidhogg:isDead(), 'Mob is alive when it should have just been despawned.')

    -- Spawn mob with claim shield
    nidhogg:setMobMod(xi.mobMod.ClaimShield, 1)
    SpawnMob(nidhogg:getID())
    assert(nidhogg:isAlive(), 'Mob did not spawn as expected.')

    blmClient1:gotoEntity(nidhogg)
    blmClient2:gotoEntity(nidhogg)

    blmClient1:useSpell(nidhogg, xi.spell.DIA)
    blmClient2:useSpell(nidhogg, xi.spell.FREEZE)

    -- Verify both have started casting
    world:tick()
    assert(blm1:getCurrentAction() == 30,
        string.format("Player is currently doing an action it shouldn't be: %u", blm1:getCurrentAction()))
    assert(blm2:getCurrentAction() == 30,
        string.format("Player is currently doing an action it shouldn't be: %u", blm2:getCurrentAction()))

    -- Wait for fast spell to finish casting
    world:skipTime(2)
    world:tick()
    world:skipTime(2)
    world:tick()

    -- Fast spell finished, but didn't claim.
    assert(blm1:getCurrentAction() ~= 30,
        string.format("Player is currently doing an action it shouldn't be: %u", blm1:getCurrentAction()))
    assert(nidhogg:getMobClaimer() == 0, 'Claim was not blocked by claim shield as expected.')

    -- Wait for long spell to finish casting
    world:skipTime(17)
    world:tick()
    world:skipTime(2)
    world:tick()

    -- Long spell finished and it did claim.
    assert(blm2:getCurrentAction() ~= 30,
        string.format("Player is currently doing an action it shouldn't be: %u", blm2:getCurrentAction()))
    assert(nidhogg:getMobClaimer() == blm2:getID(), 'Claim was not successfully with long spell.')
end

return suite
