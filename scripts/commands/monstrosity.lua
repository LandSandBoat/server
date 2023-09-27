local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = ''
}

local monstrositySpecies =
{
    RABBIT    = 1,
    BEHEMOTH  = 2,
    TIGER     = 3,
    SHEEP     = 4,
    RAM       = 5,
    DHALMEL   = 6,
    COEURL    = 7,
    OPO_OPO   = 8,
    MANTICORE = 9,
    BUFFALO   = 10,
    MARID     = 11,
    CERBERUS  = 12,
    GNOLE     = 13,

    -- No 14?

    FUNGUAR        = 15,
    TREANT_SAPLING = 16,
    MORBOL         = 17,
    MANDRAGORA     = 18,
    SABOTENDER     = 19,
    FLYTRAP        = 20,
    GOOBBUE        = 21,
    RAFFLESIA      = 22,
    PANOPT         = 23,

    -- No 24-26?

    BEE          = 27,
    BEETLE       = 28,
    CRAWLER      = 29,
    FLY          = 30,
    SCORPION     = 31,
    SPIDER       = 32,
    ANTLION      = 33,
    DIREMITE     = 34,
    CHIGOE       = 35,
    WAMOURACAMPA = 36,
    LADYBUG      = 37,
    GNAT         = 38,

    -- No 39-42?

    LIZARD      = 43,
    RAPTOR      = 44,
    ADAMANTOISE = 45,
    BUGARD      = 46,
    EFT         = 47,
    WIVRE       = 48,
    PEISTE      = 49,

    -- No 50-52?

    SLIME    = 52,
    HECTEYES = 53,
    FLAN     = 54,
    SLUG     = 56,
    SANDWORM = 57,
    LEECH    = 58,

    -- No 59?

    CRAB     = 60,
    PUGIL    = 61,
    SEA_MONK = 62,
    URAGNITE = 63,
    OROBON   = 64,
    RUSZOR   = 65,
    TOAD     = 66,

    -- No 67-68

    BIRD       = 69,
    COCKATRICE = 70,
    ROC        = 71,
    BAT        = 72,
    HIPPOGRYPH = 73,
    APKALLU    = 74,
    COLIBRI    = 75,
    AMPHIPTERE = 76,

    -- Others are not part of the regular structure, but it's useful to map them here anyway.
    -- Using arbitrary offsets!
    DQ_SLIME       = 77,
    FFXIV_SPRIGGAN = 81,
}

local monstrosityVariants =
{
    -- Rabbit
    ONYX_RABBIT      = 0,
    ALABASTER_RABBIT = 1,
    LAPINION         = 2,

    -- Behemoth
    ELSAMOTH = 3,
}

commandObj.onTrigger = function(player)
    --[[
    if player:getCharVar('MONSTROSITY_START') == 1 then
        player:setCharVar('MONSTROSITY_START', 0)
    else
        player:setCharVar('MONSTROSITY_START', 1)
    end

    player:setPos(player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos(), player:getZoneID())
    ]]
    local data =
    {
        face = 74,
        race = 11,

        -- 1 byte per entry, mapped out to monstrositySpecies table
        levels =
        {
        },

        -- Bitfield
        instincts =
        {
        },

        variants =
        {
        },
    }

    -- Set all levels to 99
    for _, val in pairs(monstrositySpecies) do
        data.levels[val] = 99
    end

    -- Instincts
    -- NOTE: Since this is a bitfield, it's zero-indexed!
    for key, val in pairs(monstrositySpecies) do
        local speciesKey   = val
        local speciesLevel = data.levels[val]
        local byteOffset   = math.floor(speciesKey / 4)
        local unlockAmount = math.floor(speciesLevel / 30)
        local shiftAmount  = (speciesKey * 2) % 8
        -- print(key, speciesKey, speciesLevel, unlockAmount, byteOffset .. ':' .. shiftAmount)
        if byteOffset < 64 then
            data.instincts[byteOffset] = bit.bor(data.instincts[byteOffset] or 0, bit.lshift(unlockAmount, shiftAmount))
        else
            print("byteOffset out of range")
        end
    end

    -- Variants
    data.variants[0x00] = bit.bor(data.variants[0x00] or 0, bit.lshift(0xFF, 0))

    player:setMonstrosity(data);
end

return commandObj
