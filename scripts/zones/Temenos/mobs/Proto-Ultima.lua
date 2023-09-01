-----------------------------------
-- Area: Temenos
--  Mob: Proto-Ultima
-----------------------------------
local ID = zones[xi.zone.TEMENOS]
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMagicCastingEnabled(false)
    mob:setAutoAttackEnabled(true)
    mob:setMobAbilityEnabled(true)
    mob:setMobMod(xi.mobMod.DRAW_IN, 0)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 729)
end

entity.onMobFight = function(mob, target)
    if not mob:actionQueueEmpty() then
        return
    end

    local phase = mob:getLocalVar('phase')
    if mob:getHPP() < (5 - (phase + 1)) * 20 then
        mob:useMobAbility(1524) -- use Dissipation on phase change
        phase = phase + 1

        if phase == 1 then
            mob:setMobMod(xi.mobMod.SKILL_LIST, 1193)
        elseif phase == 2 then
            mob:setMobMod(xi.mobMod.SKILL_LIST, 1194)
                -- Enable Holy II after a short delay so Dissipation will go off first
            mob:timer(1000, function(mobArg)
                mob:setMagicCastingEnabled(true)
            end)
        elseif phase == 3 then
            mob:setMobMod(xi.mobMod.SKILL_LIST, 1195)
        elseif phase == 4 then
            mob:setMobMod(xi.mobMod.SKILL_LIST, 1196)
            mob:setMod(xi.mod.REGAIN, 100)
            mob:setLocalVar('citadelBusterTime', os.time() + math.random(20, 30))
        end

        mob:setLocalVar('phase', phase)
    elseif phase == 4 and os.time() >= mob:getLocalVar('citadelBusterTime') then
        mob:setMobAbilityEnabled(false)
        mob:setMagicCastingEnabled(false)
        mob:setAutoAttackEnabled(false)
        mob:setMobMod(xi.mobMod.DRAW_IN, 1)
        entity.executeCitadelBusterState(mob)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- After using Nuclear Waste use a random elemental conal attack
    if skill:getID() == 1268 then
        mob:timer(4000, function(mobArg)
            local ability = math.random(1262, 1267)
            mob:useMobAbility(ability)
        end)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.TEMENOS_LIBERATOR)
    end
end

local citadelBusterTimers =
{
    [0] = 0,
    [1] = 10000,
    [2] = 10000,
    [3] = 5000,
    [4] = 1000,
    [5] = 1000,
    [6] = 1000,
    [7] = 1000,
    [8] = 1000,
    [9] = 500,
}

local function sendMessageToList(playerList, messageID)
    for _, member in pairs(playerList) do
        member:messageSpecial(messageID)
    end
end

entity.executeCitadelBusterState = function(mob)
    if mob:isDead() then
        return
    end

    local state = mob:getLocalVar('citadelBusterState')
    local battlefield = mob:getBattlefield()
    local players = battlefield:getPlayers()

    -- Message-only states
    if state < 8 then
        sendMessageToList(players, ID.text.CITADEL_BASE + state)
    elseif state == 8 then
        mob:useMobAbility(1540)
    else
        mob:setLocalVar('citadelBusterState', 0)
        mob:setMagicCastingEnabled(true)
        mob:setAutoAttackEnabled(true)
        mob:setMobAbilityEnabled(true)
        mob:setMobMod(xi.mobMod.DRAW_IN, 0)
        -- Use Citadel Buster at a regular interval
        mob:setLocalVar('citadelBusterTime', os.time() + math.random(90, 100))
        return
    end

    state = state + 1
    mob:setLocalVar('citadelBusterState', state)
    mob:timer(citadelBusterTimers[state], function(mobArg)
        entity.executeCitadelBusterState(mobArg)
    end)
end

return entity
