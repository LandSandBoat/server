-----------------------------------
-- Crafting utility functions
-----------------------------------
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.crafting = xi.crafting or {}
-----------------------------------
-- Document the "Guild_Member" bitmask.
-- Bit  0: Has joined Fishing guild.
-- Bit  1: Has joined Woodworking guild.
-- Bit  2: Has joined Smithing guild.
-- Bit  3: Has joined Goldsmithing guild.
-- Bit  4: Has joined Clothcraft guild.
-- Bit  5: Has joined Leathercraft guild.
-- Bit  6: Has joined Bonecraft guild.
-- Bit  7: Has joined Alchemy guild.
-- Bit  8: Has joined Cooking guild.

-- Bit 24: Has spoken to "Fatimah" after joining Goldsmithing guild.
-- Bit 25: Has spoken to "Azima" afer joining Alchemy guild.

-- Bit 27: Unknown, but this bits are used. Captured them on a lvl 110 Alchemist with a stage 2 Escutcheon completed.
-- Bit 28: Unknown, but this bits are used. Captured them on a lvl 110 Alchemist with a stage 2 Escutcheon completed.
-- Bit 29: Unknown, but this bits are used. Captured them on a lvl 110 Alchemist with a stage 2 Escutcheon completed.
-- Bit 30: Unknown, but this bits are used. Captured them on a lvl 110 Alchemist with a stage 2 Escutcheon completed.

xi.crafting.guildTable =
{
    --           [guild ID] = { skill used,            'currency used'      },
    [xi.guild.FISHING     ] = { xi.skill.FISHING,      'guild_fishing'      },
    [xi.guild.WOODWORKING ] = { xi.skill.WOODWORKING,  'guild_woodworking'  },
    [xi.guild.SMITHING    ] = { xi.skill.SMITHING,     'guild_smithing'     },
    [xi.guild.GOLDSMITHING] = { xi.skill.GOLDSMITHING, 'guild_goldsmithing' },
    [xi.guild.CLOTHCRAFT  ] = { xi.skill.CLOTHCRAFT,   'guild_weaving'      },
    [xi.guild.LEATHERCRAFT] = { xi.skill.LEATHERCRAFT, 'guild_leathercraft' },
    [xi.guild.BONECRAFT   ] = { xi.skill.BONECRAFT,    'guild_bonecraft'    },
    [xi.guild.ALCHEMY     ] = { xi.skill.ALCHEMY,      'guild_alchemy'      },
    [xi.guild.COOKING     ] = { xi.skill.COOKING,      'guild_cooking'      },
}

xi.crafting.hasJoinedGuild = function(player, guildId)
    local joinedGuildMask = player:getCharVar('Guild_Member')

    return utils.mask.getBit(joinedGuildMask, guildId)
end

xi.crafting.getCraftSkillCap = function(player, skillId)
    local rank = player:getSkillRank(skillId)

    return (rank + 1) * 10
end

xi.crafting.getRealSkill = function(player, skillId)
    return math.floor(player:getCharSkillLevel(skillId) / 10)
end
