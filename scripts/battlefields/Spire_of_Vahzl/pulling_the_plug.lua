-----------------------------------
-- Pulling the Plug
-- Spire of Vahzl ENM50
-- !addkeyitem 673
-----------------------------------
local spireOfVahzlID = zones[xi.zone.SPIRE_OF_VAHZL]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.SPIRE_OF_VAHZL,
    battlefieldId    = xi.battlefield.id.PULLING_THE_PLUG,
    allowTrusts      = false,
    maxPlayers       = 18,
    levelCap         = 50,
    timeLimit        = utils.minutes(30),
    index            = 1,
    entryNpc         = '_0n0',
    exitNpcs         = { '_0n1', '_0n2', '_0n3' },
    requiredKeyItems = { xi.ki.CENSER_OF_ACRIMONY, message = spireOfVahzlID.text.FADES_INTO_NOTHINGNESS },
    grantXP          = 3000,
    armouryCrates    =
    {
        spireOfVahzlID.mob.MEMORY_RECEPTACLE_RED + 9,
        spireOfVahzlID.mob.MEMORY_RECEPTACLE_RED + 19,
        spireOfVahzlID.mob.MEMORY_RECEPTACLE_RED + 29,
    },
})

-- Table of coordinated positions per shield receptacle per battlefield area
-- Shield Receptacles move around the room in a coordinated formation every 30 seconds, choosing a random entry from this table each time
content.positions =
{
    [1] =
    {
        [1] =
        {
            { x = -249.450, y = 60.75, z =  -8.710 }, -- NE
            { x = -230.980, y = 60.75, z =  -8.650 }, -- NW
            { x = -230.650, y = 60.75, z =   9.290 }, -- SW
            { x = -249.310, y = 60.75, z =  10.030 }, -- SE
            { x = -224.921, y = 60.00, z =  -0.095 }, -- WW
            { x = -255.249, y = 60.00, z =   0.028 }, -- NN
            { x = -240.320, y = 60.00, z = -14.790 }, -- EE
            { x = -224.921, y = 60.00, z =  -0.095 }, -- WW
        },

        [2] =
        {
            { x = -240.022, y = 60.75, z =  -9.150 }, -- N
            { x = -230.690, y = 60.75, z =  -0.360 }, -- W
            { x = -239.835, y = 60.75, z =   9.620 }, -- S
            { x = -249.410, y = 60.75, z =   0.078 }, -- E
            { x = -240.320, y = 60.00, z = -14.790 }, -- EE
            { x = -240.320, y = 60.00, z = -14.790 }, -- EE
            { x = -224.921, y = 60.00, z =  -0.095 }, -- WW
            { x = -255.249, y = 60.00, z =   0.028 }, -- NN
        },

        [3] =
        {
            { x = -230.980, y = 60.75, z =  -8.650 }, -- NW
            { x = -230.650, y = 60.75, z =   9.290 }, -- SW
            { x = -249.310, y = 60.75, z =  10.030 }, -- SE
            { x = -249.450, y = 60.75, z =  -8.710 }, -- NE
            { x = -255.249, y = 60.00, z =   0.028 }, -- NN
            { x = -224.921, y = 60.00, z =  -0.095 }, -- WW
            { x = -239.954, y = 60.00, z =  15.768 }, -- SS
            { x = -240.320, y = 60.00, z = -14.790 }, -- EE
        },
    },

    [2] =
    {
        [1] =
        {
            { x =  -9.450, y = 0.75, z =  -8.710 }, -- NE
            { x =  10.980, y = 0.75, z =  -8.650 }, -- NW
            { x =  10.650, y = 0.75, z =   9.290 }, -- SW
            { x =  -9.310, y = 0.75, z =  10.030 }, -- SE
            { x =  16.921, y = 0.00, z =  -0.095 }, -- WW
            { x = -15.249, y = 0.00, z =   0.028 }, -- NN
            { x =   0.320, y = 0.00, z = -14.790 }, -- EE
            { x =  16.921, y = 0.00, z =  -0.095 }, -- WW
        },

        [2] =
        {
            { x =   0.022, y = 0.75, z =  -9.150 }, -- N
            { x =  10.690, y = 0.75, z =  -0.360 }, -- W
            { x =   1.835, y = 0.75, z =   9.620 }, -- S
            { x =  -9.410, y = 0.75, z =   0.078 }, -- E
            { x =   0.320, y = 0.00, z = -14.790 }, -- EE
            { x =   0.320, y = 0.00, z = -14.790 }, -- EE
            { x =  16.921, y = 0.00, z =  -0.095 }, -- WW
            { x = -15.249, y = 0.00, z =   0.028 }, -- NN
        },

        [3] =
        {
            { x =  10.980, y = 0.75, z =  -8.650 }, -- NW
            { x =  10.650, y = 0.75, z =   9.290 }, -- SW
            { x =  -9.310, y = 0.75, z =  10.030 }, -- SE
            { x =  -9.450, y = 0.75, z =  -8.710 }, -- NE
            { x = -15.249, y = 0.00, z =   0.028 }, -- NN
            { x =  16.921, y = 0.00, z =  -0.095 }, -- WW
            { x =  -0.092, y = 0.00, z =  16.114 }, -- SS
            { x =   0.320, y = 0.00, z = -14.790 }, -- EE
        },
    },

    [3] =
    {
        [1] =
        {
            { x = 231.450, y = -59.75, z =  -8.710 }, -- NE
            { x = 250.980, y = -59.75, z =  -8.650 }, -- NW
            { x = 250.650, y = -59.75, z =   9.290 }, -- SW
            { x = 231.310, y = -59.75, z =  10.030 }, -- SE
            { x = 256.921, y = -60.00, z =  -0.095 }, -- WW
            { x = 225.249, y = -60.00, z =   0.028 }, -- NN
            { x = 240.320, y = -60.00, z = -14.790 }, -- EE
            { x = 256.921, y = -60.00, z =  -0.095 }, -- WW
        },

        [2] =
        {
            { x = 240.022, y = -59.75, z =  -9.150 }, -- N
            { x = 250.690, y = -59.75, z =  -0.360 }, -- W
            { x = 241.835, y = -59.75, z =   9.620 }, -- S
            { x = 231.410, y = -59.75, z =   0.078 }, -- E
            { x = 240.320, y = -60.00, z = -14.790 }, -- EE
            { x = 240.320, y = -60.00, z = -14.790 }, -- EE
            { x = 256.921, y = -60.00, z =  -0.095 }, -- WW
            { x = 225.249, y = -60.00, z =   0.028 }, -- NN
        },

        [3] =
        {
            { x = 250.980, y = -59.75, z =  -8.650 }, -- NW
            { x = 250.650, y = -59.75, z =   9.290 }, -- SW
            { x = 231.310, y = -59.75, z =  10.030 }, -- SE
            { x = 231.450, y = -59.75, z =  -8.710 }, -- NE
            { x = 225.249, y = -60.00, z =   0.028 }, -- NN
            { x = 256.921, y = -60.00, z =  -0.095 }, -- WW
            { x = 239.720, y = -60.00, z =  16.031 }, -- SS
            { x = 240.320, y = -60.00, z = -14.790 }, -- EE
        },
    },
}

-- Every 30 seconds, shield receptacles choose a new position slot and move to it in a coordinated formation
function content:onBattlefieldTick(battlefield, tick)
    Battlefield.onBattlefieldTick(self, battlefield, tick)

    local moveTimer = battlefield:getLocalVar('moveTimer')
    local area      = battlefield:getArea()
    local offset    = (area - 1) * 10

    if moveTimer > 0 and GetSystemTime() >= moveTimer then
        -- All shields share the same position entry ID to maintain a coordinated formation
        local positions    = self.positions
        local lastPosition = battlefield:getLocalVar('position')
        local newPosition  = math.random(1, #positions[area][1])

        -- Ensure position is new
        while newPosition == lastPosition do
            newPosition = math.random(1, #positions[area][1])
        end

        battlefield:setLocalVar('position', newPosition)

        for i = 0, 2 do
            local shieldMob = GetMobByID(spireOfVahzlID.mob.MEMORY_RECEPTACLE_SHIELD + offset + i)

            if shieldMob and shieldMob:isAlive() then
                local targetPos = positions[area][i + 1][newPosition]

                shieldMob:setLocalVar('wasPathing', 1)
                shieldMob:setMobMod(xi.mobMod.NO_MOVE, 0)
                shieldMob:pathTo(targetPos.x, targetPos.y, targetPos.z)
            end
        end

        battlefield:setLocalVar('moveTimer', GetSystemTime() + 30)
    end
end

content.groups =
{
    {
        mobs     = { 'Memory_Receptacle_Red' },
        allDeath = utils.bind(content.handleAllMonstersDefeated, content),
    },

    {
        mobs    = { 'Memory_Receptacle_Shield', 'Contemplator', 'Ingurgitator', 'Repiner', 'Neoingurgitator' },
        spawned = false,
    },
}

content.loot =
{
    {
        { itemId = xi.item.CLUSTER_OF_BITTER_MEMORIES,     weight = 1250 },
        { itemId = xi.item.CLUSTER_OF_BURNING_MEMORIES,    weight = 1250 },
        { itemId = xi.item.CLUSTER_OF_FLEETING_MEMORIES,   weight = 1250 },
        { itemId = xi.item.CLUSTER_OF_MALEVOLENT_MEMORIES, weight = 1250 },
        { itemId = xi.item.CLUSTER_OF_PROFANE_MEMORIES,    weight = 1250 },
        { itemId = xi.item.CLUSTER_OF_RADIANT_MEMORIES,    weight = 1250 },
        { itemId = xi.item.CLUSTER_OF_SOMBER_MEMORIES,     weight = 1250 },
        { itemId = xi.item.CLUSTER_OF_STARTLING_MEMORIES,  weight = 1250 },
    },

    {
        { itemId = xi.item.BEATIFIC_IMAGE,                 weight = 3334 },
        { itemId = xi.item.GRAVE_IMAGE,                    weight = 3333 },
        { itemId = xi.item.VALOROUS_IMAGE,                 weight = 3333 },
    },

    {
        { itemId = xi.item.ANCIENT_IMAGE,                  weight = 5000 },
        { itemId = xi.item.VIRGIN_IMAGE,                   weight = 5000 },
    },

    {
        { itemId = xi.item.NONE,                           weight = 7000 },
        { itemId = xi.item.IMPETUOUS_VISION,               weight = 1500 },
        { itemId = xi.item.SNIDE_VISION,                   weight = 1000 },
        { itemId = xi.item.TENUOUS_VISION,                 weight =  500 },
    },
}

return content:register()
