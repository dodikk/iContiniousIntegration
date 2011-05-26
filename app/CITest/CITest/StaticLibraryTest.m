#import <CITest-Model/CITMathCore.h>
#import <CITest-Model-Universal/CITUMathCore.h>

@interface StaticLibraryTest : GHTestCase
@end


@implementation StaticLibraryTest

-(void)testAdd
{
   NSUInteger expected_ = 0;
   NSUInteger received_ = 0;
   
   CITMathCore* model_ = [ [ [ CITMathCore alloc ] init ] autorelease ];
   
   {
      expected_ = 4;
      received_ = [ model_ addInteger: 2
                            toInteger: 2 ];
      
      GHAssertTrue( expected_ == received_, @"math failed" );
   }

   {
      expected_ = 100;
      received_ = [ model_ addInteger: 99
                            toInteger: 1 ];
      
      GHAssertTrue( expected_ == received_, @"math failed" );
   }
}

-(void)testMul
{
   NSUInteger expected_ = 0;
   NSUInteger received_ = 0;
   
   CITUMathCore* model_ = [ [ [ CITUMathCore alloc ] init ] autorelease ];
   
   {
      expected_ = 4;
      received_ = [ model_ mulInteger: 2
                          withInteger: 2 ];
      
      GHAssertTrue( expected_ == received_, @"math failed" );
   }
   
   {
      expected_ = 99;
      received_ = [ model_ mulInteger: 99
                          withInteger: 1 ];
      
      GHAssertTrue( expected_ == received_, @"math failed" );
   }   
   
   {
      expected_ = 0;
      received_ = [ model_ mulInteger: 10000
                          withInteger: 0 ];
      
      GHAssertTrue( expected_ == received_, @"math failed" );
   }   
   
}

@end
