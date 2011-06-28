//
//  GeniusTouchViewController.m
//  GeniusTouch
//
//  Created by Matheus Brum on 10/06/11.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//
#import "GeniusTouchViewController.h"

@implementation GeniusTouchViewController
@synthesize arrayMaster,botaoComecar,imagemFundo;
@synthesize som1,som2,som3,som4,error;
- (void)viewDidLoad {
	jogoRodando=NO;
	arrayMaster=[[NSMutableArray alloc]init];
	//inicializando os sons
	AudioServicesCreateSystemSoundID ((CFURLRef ) [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"3" ofType:@"wav"]], &som1);
	AudioServicesCreateSystemSoundID ((CFURLRef ) [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"4" ofType:@"wav"]], &som2);
	AudioServicesCreateSystemSoundID ((CFURLRef ) [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"wav"]], &som3);
	AudioServicesCreateSystemSoundID ((CFURLRef ) [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"2" ofType:@"wav"]], &som4);
	AudioServicesCreateSystemSoundID ((CFURLRef ) [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"error" ofType:@"wav"]], &error);
	[super viewDidLoad];
}
-(IBAction)corEscolhida:(id)sender{//um tecla foi acionada
	[self tocarSom:[sender tag]];//o som deve ser tocado, relativo a tecla acionada
	if (jogoRodando==YES) {//SE o jogo esta ativo
		if ([sender tag]==[[arrayMaster objectAtIndex:rodadaEscolhendo]intValue]) {//SE o botão apertado é igual ao objeto do array 
			rodadaEscolhendo++;// a proxima tecla deve ser comparada com o proximo objeto do array
			if ([arrayMaster count]==rodadaEscolhendo) {//SE o numero de objetos no array for igual ao numero de objetos a ser comparado quer dizer que a sequencia acabou
				rodadaEscolhendo=0;//o numero a ser comparado deve ser resetado
				[self escurecer];//escurece a tela, para demonstrao ao usuário que é vez do computador
				[NSTimer  scheduledTimerWithTimeInterval:1.6f target:self selector:@selector(adicionar) userInfo:nil repeats:NO];//em um delay de 1.6 segundos começara a proxima rodada
			}
		}else {//SE o botão apertado é diferente do objeto no array, o usuario erro
			AudioServicesPlaySystemSound (error);//toca o som de erro
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
			[UIView setAnimationDuration:0.3];
			botaoComecar.transform =  CGAffineTransformMakeTranslation(0, -1);	//animação para voltar o botão "Start"
			[UIView commitAnimations];		
			jogoRodando=NO;//especifica que o jogo acabou
		}
	}
}
-(IBAction)comecar{// o botão "Start" foi pressionado
	if ([arrayMaster count]>0) {//SE o array diver objetos ele deverá ser limpo
		[arrayMaster removeAllObjects];//exclui todos os objetos do array, ja que começará um novo jogo
	}
	[self adicionar];//adiciona um objeto randômico ao array
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDuration:0.3];
	botaoComecar.transform =  CGAffineTransformMakeTranslation(0, 200);	//animação para esconder o botão "Start"
	[UIView commitAnimations];		
	jogoRodando=YES;//especifica que o jogo está em andamento
	rodadaTocando=0;//o botão a ser tocado começará do zero
	rodadaEscolhendo=0;//o objeto a ser comparado começará do zero
}
-(void)escurecer{//função para esconder a tela 
	self.view.userInteractionEnabled=NO;//já que o iPhone tomará o controle para tocar a sequencia, a interação do usuário torna-se impossibilidata
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[imagemFundo setAlpha:0];//a imagem do fundo sai e fica apenas o fundo da view, que é preto
	[UIView commitAnimations];
}
-(void)adicionar{//função para adicionar um objeto ao array
	int numeroRand= 1+arc4random()%4;//sorteia um uma variavel inteira entre 1 e 4
	[arrayMaster addObject:[NSNumber numberWithInt:numeroRand]];//já que uma variavel int não é um objeto especificamente, devemos criar um NSNumber com ela, depois adicionar
	[self tocarSequencia];//toca o numero adicionado
}
-(void)tocarSequencia{
	if (rodadaTocando<[arrayMaster count]) {//SE ainda há objetos a analisados e tocados...
		int num=[[arrayMaster objectAtIndex:rodadaTocando]intValue];//cria uma variável com o numero no array que está sendo analisado (criei uma variável porque será utilizada multiplas vezes)
		UIButton *botao = (UIButton*)[self.view viewWithTag:num];//cria um botão com a tag do numero
		[botao setHighlighted:YES];//o botão sofre a animação de ser selecionado, para indicar a sequencia
		[self tocarSom:num];//toca o som do botão
		[NSTimer  scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(esconderBotao) userInfo:nil repeats:NO];//o botão está selecionado, depois de 1s ele é descelecionado
	}else {
		rodadaTocando = 0;//Se não há mais objetos
		self.view.userInteractionEnabled =YES;//a interação na tela deve ser devolvida ao usuário
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.5];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		[imagemFundo setAlpha:1];//a imagem de fundo volta
		[UIView commitAnimations];
	}
}
-(void)esconderBotao{//função para voltar o botão que está selecionado ao normal
	UIButton *botao = (UIButton*)[self.view viewWithTag:[[arrayMaster objectAtIndex:rodadaTocando]intValue]];//especifica o mesmo botão que está selecionado
	[botao setHighlighted:NO];//desceleciona o botão
	rodadaTocando++;//já foi tocada essa sequencia, devemos partir para a próxima
	[self tocarSequencia];//parte para a proxima sequencia
}
-(void)tocarSom:(int)som{//toca os sons das teclas decorrente da tag do botão
	switch (som) {
		case 1:
			AudioServicesPlaySystemSound (som1);
			break;
		case 2:
			AudioServicesPlaySystemSound (som2);
			break;
		case 3:
			AudioServicesPlaySystemSound (som3);
			break;
		case 4:
			AudioServicesPlaySystemSound (som4);
			break;
	}
}
-(IBAction)info{//alerta de informações no blog
	UIAlertView *alerta =[[UIAlertView alloc]initWithTitle:@"Apple Maníacos" message:@"Este programa foi desenvolvido por Matheus Brum e seu código é disponível gratuitamente pelo blog AppleManiacos.com" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Visitar Blog",nil];
	[alerta show];
	[alerta release];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewDidUnload {
}
- (void)dealloc {
	[arrayMaster release];
	[imagemFundo release];
	[botaoComecar release];
    [super dealloc];
}
@end
