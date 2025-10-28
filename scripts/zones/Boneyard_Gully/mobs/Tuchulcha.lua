-----------------------------------
-- Area: Boneyard Gully
--  Mob: Tuchulcha
--  ENM: Sheep in Antlion's Clothing
-- TODO : Create function to augment fTP modifier for Antlion Ambush to make it do more damage.
-----------------------------------
mixins = { require('scripts/mixins/families/antlion_ambush') }
local ID = zones[xi.zone.BONEYARD_GULLY]
-----------------------------------
---@type TMobEntity
local entity = {}

-- We use this duplicate table to look up coordinates from variables assigned in the battlefield setup.
local antlionPositions =
{
    [1] =
    {
        { -516,  0.0, -517, 171 },
        { -533,  0.2, -460, 171 },
        { -552,  2.2, -440, 171 },
        { -570, -3.6, -464, 171 },
        { -589,  0.2, -484, 171 },
        { -527,  0.2, -471, 171 },
        { -530,  0.3, -478, 171 },
        { -574,  0.6, -478, 171 },
        { -560,  0.0, -476, 171 },
        { -596,  0.2, -478, 171 },
        { -570,  3.0, -433, 171 },
    },

    [2] =
    {
        { 43,  0.0,  40, 7 },
        { 27,  0.2,  99, 7 },
        { 7,   2.2, 117, 7 },
        { -11, 3.4,  96, 7 },
        { -30, 0.2,  76, 7 },
        { 32,  0.2,  89, 7 },
        { 29,  0.3,  82, 7 },
        { -15, 0.6,  82, 7 },
        { -1,  0.0,  84, 7 },
        { -37, 0.2,  82, 7 },
        { -11, 3.0, 127, 7 },
    },

    [3] =
    {
        { 522,  0.0, 528, 240 },
        { 505,  0.2, 585, 240 },
        { 486,  2.2, 605, 240 },
        { 468,  3.4, 575, 240 },
        { 449,  0.2, 555, 240 },
        { 511,  0.2, 568, 240 },
        { 508,  0.3, 561, 240 },
        { 464,  0.6, 561, 240 },
        { 478,  0.0, 563, 240 },
        { 442,  0.2, 561, 240 },
        { 468,  3.0, 606, 240 },
    },
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.SUPERLINK, 0)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.PARALYZE)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('sandpitsUsed', 0)

    mob:addListener('WEAPONSKILL_STATE_EXIT', 'TUCHULCHA_SANDPIT', function(tuchulcha, skillID)
        if
            skillID == xi.mobSkill.SANDPIT_1 and
            tuchulcha:getLocalVar('sandpitTriggered') == 1
        then
            -- Prevent further teleports until the next triggered Sandpit.
            tuchulcha:setLocalVar('sandpitTriggered', 0)

            -- Disable movement and prevent healing while underground.
            tuchulcha:disengage()
            tuchulcha:setMobMod(xi.mobMod.NO_MOVE, 1)
            tuchulcha:setMobMod(xi.mobMod.NO_REST, 1)

            -- Fetch the next Sandpit coordinates.
            local pitNum      = tuchulcha:getLocalVar('sandpitsUsed')
            local posIndex    = tuchulcha:getLocalVar('sand_pit' .. tostring(pitNum))
            local area        = tuchulcha:getBattlefield():getArea()
            local coordinates = antlionPositions[area] and antlionPositions[area][posIndex] or nil

            if coordinates then
                -- Force disengage all player characters & pets in the battlefield. We also play the flavor text here.
                local players = tuchulcha:getBattlefield():getPlayers()
                for _, char in pairs(players) do
                    char:messageSpecial(ID.text.TUCHULCHA_SANDPIT)
                    char:disengage()
                    if char:hasPet() then
                        char:petRetreat()
                    end
                end

                -- Move Tuchulcha to the new Sandpit location.
                tuchulcha:setPos(unpack(coordinates))
            end
        end
    end)
end

entity.onMobEngage = function(mob, target)
    -- Re-enable normal behavior after emerging from Antlion Ambush.
    if mob:getMobMod(xi.mobMod.NO_REST) == 1 then
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        mob:setMobMod(xi.mobMod.NO_REST, 0)
        mob:setAutoAttackEnabled(true)
    end
end

entity.onMobFight = function(mob, target)
    local mobHPP  = mob:getHPP()
    local pit = mob:getLocalVar('sandpitsUsed')

    if
        (mobHPP < 75 and
        pit == 0) or
        (mobHPP < 50 and
        pit == 1) or
        (mobHPP < 25 and
        pit == 2)
    then
        if xi.combat.behavior.isEntityBusy(mob) then -- We check if Tuchulcha is busy here to prevent any overlapping abilities triggering our injected action packet.
            return
        end

        mob:setLocalVar('sandpitsUsed', pit + 1)

        -- Every 25% HP, use Sandpit to burrow to a new location.
        mob:useMobAbility(xi.mobSkill.SANDPIT_1, nil, 1)
        mob:setLocalVar('sandpitTriggered', 1) -- Protect against multiple teleports.

        -- We inject this action after a short delay to create the "dust cloud" effect.
        mob:timer(500, function(tuchulchaMob)
            tuchulchaMob:injectActionPacket(tuchulchaMob:getID(), 11, 435, 0, 0x18, 0, 0, 0)
        end)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- Despawn remaining Antlions when Tuchulcha dies.
    if optParams.isKiller or optParams.noKiller then
        local base = mob:getID()
        for id = base + 1, base + 3 do
            DespawnMob(id)
        end
    end
end

return entity
