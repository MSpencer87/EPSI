#include <iostream>
#include <fstream>
#include <vector>
#include <string>

using namespace std;

int main(int argv, char** argc)
{
	fstream file;

	vector<string> dict;
	string value;
	file.open(argc[1]);
	
	while(file >> value)
	{
		string upvalue = value; 	
		upvalue[1] = toupper(upvalue[1]);
		dict.push_back(upvalue);
	}
	
	for(int i = 0; i < dict.size(); i++)
	{
		cout << dict[i] << endl;
	}
}

