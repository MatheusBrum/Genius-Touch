//
//  GeniusTouchViewController.h
//  GeniusTouch
//
//  Created by Matheus Brum on 11/06/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>


@interface GeniusTouchViewController : UIViewController {
	NSMutableArray *arrayMaster;
	int rodadaTocando;
	int rodadaEscolhendo;
	bool jogoRodando;
	SystemSoundID som1;
	SystemSoundID som2;
	SystemSoundID som3;
	SystemSoundID som4;
	SystemSoundID error;
	IBOutlet UIButton *botaoComecar;
	IBOutlet UIImageView *imagemFundo;
}
@property(nonatomic)SystemSoundID som1;
@property(nonatomic)SystemSoundID som2;
@property(nonatomic)SystemSoundID som3;
@property(nonatomic)SystemSoundID som4;
@property(nonatomic)SystemSoundID error;
@property(nonatomic,retain)UIButton *botaoComecar;
@property(nonatomic,retain)UIImageView *imagemFundo;
@property(nonatomic,retain)NSMutableArray *arrayMaster;
-(IBAction)corEscolhida:(id)sender;
-(IBAction)comecar;
-(IBAction)info;
-(void)tocarSequencia;
-(void)adicionar;
-(void)escurecer;
-(void)esconderBotao;
-(void)tocarSom:(int)som;
@end

