-----------------------------------
-- Imperial Agent Rescue Warder utilities
-----------------------------------
local ID = zones[xi.zone.MAMOOL_JA_TRAINING_GROUNDS]
-----------------------------------
local warder = {}

local gateDamageSkills =
{
    [xi.mobSkill.FIRESPIT]                = 1,
    [xi.mobSkill.AXE_THROW]               = 4,
    [xi.mobSkill.STAVE_TOSS]              = 4,
}

warder.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)

    -- The generic weapon_break mixin can remove the visible weapon after a
    -- critical hit even though no Stave Toss or Axe Throw occurred.
    mob:setLocalVar('BreakChance', 0)
end

warder.onMobWeaponSkill = function(mob, target, skill, action)
    local hitValue = gateDamageSkills[skill:getID()]
    if not hitValue then
        return
    end

    -- Warder weapon skills have an 80% chance to damage the gate.
    if math.randomInt(1, 100) > 80 then
        return
    end

    local instance = mob:getInstance()
    if not instance then
        return
    end

    for _, gateId in ipairs(ID.mob[xi.assault.mission.IMPERIAL_AGENT_RESCUE].GATES) do
        local gate = GetMobByID(gateId, instance)
        if
            gate and
            gate:isAlive() and
            mob:checkDistance(gate) <= 10 and
            mob:isFacing(gate)
        then
            -- Briefly reveal the gate before applying damage.
            gate:hideName(false)
            gate:timer(1, function(gateArg)
                gateArg:hideName(true)
            end)

            gate:timer(2000, function(gateArg)
                if not gateArg:isAlive() then
                    return
                end

                local newHits = gateArg:getLocalVar('hits') + hitValue
                gateArg:setLocalVar('hits', newHits)

                if newHits >= 4 then
                    gateArg:setHP(0)
                end
            end)

            return
        end
    end
end

return warder
