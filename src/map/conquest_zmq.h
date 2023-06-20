#ifndef SERVER_CONQUEST_ZMQ_H
#define SERVER_CONQUEST_ZMQ_H

struct region_control_t
{
    uint8 current;
    uint8 prev;
};

struct influence_t
{
    uint16 sandoria_influence;
    uint16 bastok_influence;
    uint16 windurst_influence;
    uint16 beastmen_influence;
};

#endif // SERVER_CONQUEST_ZMQ_H
