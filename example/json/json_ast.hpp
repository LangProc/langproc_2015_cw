#ifndef json_ast_hpp
#define json_ast_hpp

#include <vector>
#include <map>
#include <stdexcept>
#include <iostream>

class Value
{
public:
    virtual ~Value()
    {}
        
    virtual void Print(std::ostream &dst) const=0;
};

class Array
    : public Value
{ 
private:    
    std::vector<Value*> entries;
public:
    Array()
    {}
    
    void Add(Value *value)
    {
        entries.push_back(value);
    }
    
    virtual void Print(std::ostream &dst) const
    {
        dst<<"[";
        for(unsigned i=0; i<entries.size(); i++){
            if(i!=0)
                dst<<",";
            entries[i]->Print(dst);
        }
        dst<<"]";
    }
};

class Object
    : public Value
{  
private:    
    typedef std::map<std::string,Value*> map_t;
    std::map<std::string,Value*> entries;
public:
    Object()
    {}
    
    void Add(std::string name, Value *value)
    {
        if(entries.find(name)!=entries.end())
            throw std::runtime_error("Name already exists.");
        entries[name]=value;
    }
    
    virtual void Print(std::ostream &dst) const
    {
        dst<<"{";
        map_t::const_iterator it=entries.begin();
        while(it!=entries.end()){
            if(it!=entries.begin())
                dst<<",";
            dst<<it->first;
            dst<<":";
            it->second->Print(dst);
            ++it;
        }
        dst<<"}";
    }
};

class String
    : public Value
{  
private:
    std::string value;
public:
    String(std::string _value)
        : value(_value)
    {}
        
    virtual void Print(std::ostream &dst) const
    {
        dst<<value;
    }
};

class Number
    : public Value
{  
private:
    double value;
public:
    Number(double _value)
        : value(_value)
    {}
        
    virtual void Print(std::ostream &dst) const
    {
        dst<<value;
    }
};

class Boolean
    : public Value
{  
private:
    bool value;
public:
    Boolean(bool _value)
        : value(_value)
    {}
        
    virtual void Print(std::ostream &dst) const
    {
        dst<<(value?"true":"false");
    }
};

class Null
    : public Value
{  
public:
    Null()
    {}
        
    virtual void Print(std::ostream &dst) const
    {
        dst<<"null";
    }
};

#endif
