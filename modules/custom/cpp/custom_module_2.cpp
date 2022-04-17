#include "../src/map/utils/moduleutils.h"
#include <iostream>

class CustomModule2 : public CPPModule
{
    void OnInit() override
    {
        std::cout << "Module2\n";
    }
};

REGISTER_CPP_MODULE(CustomModule2);
